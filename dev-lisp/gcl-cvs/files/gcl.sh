#!/bin/sh

# This script includes source from GCL's debian/in.gcl-clc.sh

if [ ! -f /usr/share/common-lisp/source/common-lisp-controller/common-lisp-controller.lisp ] ; then
  cat <<EOF
$0: cannot find the common-lisp-controller source.
EOF
  exit 0
fi

build_error() {
    echo "Build failure $1"
    exit 1
}

case $1 in
    rebuild)
	    echo $0 rebuilding...
	    shift
	    echo rebuilding $1
	    gcl -batch -eval \
"(handler-case
     (progn
       (c-l-c:compile-library (quote $1))
       (bye 0))
    (error (e)
      (ignore-errors (format t \"~&Build error: ~A~%\" e))
      (finish-output)
      (bye 1)))" || build_error
	    ;;
     remove)
	    echo $0 removing packages...
	    shift
	    while [ ! -z "$1" ] ; do
		rm -rf "/usr/lib/common-lisp/gcl/$1"
		shift
 	    done
	    ;;
    install-defsystem | install-clc)
	    echo $0 loading and dumping clc.
	    /usr/lib/gcl/unixport/saved_ansi_gcl.dist <<!INSTALL_CLC!
(in-package :common-lisp)
(unless (fboundp 'load-time-value)
  (defun load-time-value (obj) obj)
  (export (find-symbol "LOAD-TIME-VALUE")))

(in-package :common-lisp-user)
(load "/usr/share/common-lisp/source/common-lisp-controller/common-lisp-controller.lisp")

(in-package :common-lisp-controller)
(init-common-lisp-controller "gcl" :version 3)

(defun send-clc-command (command package)
  "Overrides global definition."
  (multiple-value-bind (exit-code signal-code)
	(si::system (c-l-c:make-clc-send-command-string command package "gcl"))
    (if (and (zerop exit-code) (zerop signal-code))
	  (values)
	(error "Error during ~A of ~A for ~A~%Please report this as a bug to http://bugs.gentoo.org/~%"
	       (ecase command
		 (:recompile "recompilation")
		 (:remove "removal"))
	       package
	       "gcl"))))

(in-package :asdf)

(defun run-shell-command (control-string &rest args)
"Interpolate ARGS into CONTROL-STRING as if by FORMAT, and
synchronously execute the result using a Bourne-compatible shell,
with output to *verbose-out*.  Returns the shell's exit code."
  (let ((command (apply #'format nil control-string args)))
    (format *verbose-out* "; $ ~A~%" command)
    (si::system command) ; even less *verbose-out*
    ))

(si:save-system "/usr/lib/gcl/unixport/saved_ansi_gcl.new"))
!INSTALL_CLC!
	    if test $? = 0; then
		(cd /usr/lib/gcl/unixport;
		    mv saved_ansi_gcl.new saved_ansi_gcl || (echo FAILED;
			cp saved_ansi_gcl.dist saved_ansi_gcl))
	    else
		echo $0 Error installing CLC
		exit 1
	    fi
	    ;;
    remove-defsystem | remove-clc)
	    echo $0 removing clc-enabled image
	    cp /usr/lib/gcl/unixport/saved_ansi_gcl.dist \
		/usr/lib/gcl/unixport/saved_ansi_gcl
	    ;;
    *)
	    echo $0 unkown command $1
	    echo known commands: rebuild, remove, install-clc and remove-clc
	    exit 1
	    ;;
esac

exit 0
