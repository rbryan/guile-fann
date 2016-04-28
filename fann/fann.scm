(define-module (fann fann)
	       #:use-module (system foreign)
	       #:use-module (debugging assert) ;;adds guile-lib as a dependency
	       #:export-syntax (fann-create-standard))

(define libfann (dynamic-link "libfann"))

(define-syntax-rule (fann-create-standard  arg ...)
	 (let* ((args (list arg ...))
		(largs (length args)))
	  (assert (> largs 1))
	  ((pointer->procedure '*
			      (dynamic-func "fann_create_standard" libfann)
			      (make-list largs uint32)) arg ...)))
