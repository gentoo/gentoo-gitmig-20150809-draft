;;; delegate.el --- allow delegation for lisp variables

;; Copyright (C) 2002 Daiki Ueno

;; Author: Daiki Ueno <ueno@unixuser.org>
;; Keywords: internal

;; This file is not part of any package.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Here is a simple example how this package can be used.
;; 
;; (define-delegated-variable-alias 'browse-url-browser-function
;;     'liece-url-browser-function
;;   "browse-url")
;;
;; With this, the variable `liece-url-browser-function' is declared to
;; be "delegated" to another variable.  Unlike using `defvaralias',
;; delegated variable itself is responsible for its value.  Moreover we
;; can hint the input source from which the variable is loaded.
;;
;; The delegated variable can be assigned to the default value of
;; `defcustom' form below.
;;
;; (defcustom liece-url-browser-function
;;   (delegated-variable-get-safe 'liece-url-browser-function)
;;   "Default URL Browser."
;;   :group 'liece-url)

;;; Code:

(defvar delegated-variables nil
  "Alist mapping delegated variable names to symbols and filenames.")

;;;###autoload
(put 'define-delegated-variable-alias 'lisp-indent-function 2)

;;;###autoload
(defun define-delegated-variable-alias (variable alias &optional filename)
  "Define a variable delegated to another variable."
  (let ((entry (assq alias delegated-variables)))
    (and (null filename) (boundp variable)
	 (setq filename (symbol-file variable)))
    (if entry
	(setcdr entry (list variable filename))
      (setq delegated-variables
	    (cons (list alias variable filename)
		  delegated-variables)))))

;;;###autoload
(defun delegated-variable-get (variable)
  "Return variable's value.
Error if that is not delegated to another variable."
  (let ((entry (assq variable delegated-variables))
	filename)
    (if entry
	(if (boundp variable)
	    (symbol-value variable)
	  (setq variable (nth 1 entry) filename (nth 2 entry))
	  (and (not (boundp variable)) filename
	       (load filename 'noerror))
	  (if (boundp variable)
	      (symbol-value variable)
	    (delegated-variable-get variable))) ;follow an indirection
      (signal 'wrong-type-argument
	      (list "Not a delegated variable" variable)))))

;;;###autoload
(defun delegated-variable-get-safe (variable)
  "Return variable's value.
If that is not delegated, don't throw an error.  This function is
typically used to set the default value within `defcustom' form."
  (condition-case nil
      (delegated-variable-get variable)
    (wrong-type-argument)))

(provide 'delegate)

;;; delegate.el ends here
