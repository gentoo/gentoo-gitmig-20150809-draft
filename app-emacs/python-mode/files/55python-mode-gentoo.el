
;;; python-mode site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.doctest$" . doctest-mode))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(autoload 'doctest-mode "doctest-mode" "Editing mode for Python Doctest examples." t)
(require 'pycomplete)
