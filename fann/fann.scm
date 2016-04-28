(define-module (fann fann)
	       #:use-module (system foreign)
	       #:use-module (debugging assert) ;;adds guile-lib as a dependency
	       #:export (fann-create-network))

(define libfann (dynamic-link "libfann"))

(define* (fann-create-network type . args)
	 (cond
	   ((equal? type 'standard)
	    	(let ((largs (length args)))
		  (assert (> largs 1) (= (car args) (length (cdr args)))
			  report: `(,largs (,(car args) ,(length (cdr args)))))
		  (apply (pointer->procedure '*
				      (dynamic-func "fann_create_standard" libfann)
				      (make-list largs uint32)) args)))
	   ((equal? type 'shortcut)
	    	(let ((largs (length args)))
		  (assert (> largs 1) (= (car args) (length (cdr args)))
			  report: `(,largs (,(car args) ,(length (cdr args)))))
		  (apply (pointer->procedure '*
				      (dynamic-func "fann_create_shortcut" libfann)
				      (make-list largs uint32)) args)))
	   ((equal? type 'sparse)
	    	(let* ((largs (length args)))
		  (assert (> largs 2) (= (cadr args) (length (cddr args)))
			  report: `(,largs (,(cadr args) ,(length (cddr args)))))
		  (apply (pointer->procedure '*
				      (dynamic-func "fann_create_sparse" libfann)
				      (append (list float) (make-list (- largs 1) uint32))) args)))
	   (else
	     	(error "Unknown type for new network."))))

