#!/bin/sh

if [ ! -f /usr/share/common-lisp/source/common-lisp-controller/common-lisp-controller.lisp ] ; then
  cat <<EOF
$0: cannot find the common-lisp-controller source.
EOF
  exit 0
fi

build_error()
{
    echo "Build failure $1"
    exit 1
}

case $1 in
    rebuild)
	    echo $0 rebuilding...
	    shift
	    echo rebuilding $1
	    sbcl --noinform --sysinit /etc/sbclrc --userinit /dev/null \
	         --disable-debugger \
	         --eval \
"(handler-case
     (progn
       (c-l-c:compile-library (quote $1))
       (sb-unix:unix-exit 0))
    (error (e)
      (ignore-errors (format t \"~&Build error: ~A~%\" e))
      (finish-output)
      (sb-unix:unix-exit 1)))" || build_error
	    ;;
     remove)
	    echo $0 removing packages...
	    shift
	    while [ ! -z "$1" ] ; do
		rm -rf "/usr/lib/common-lisp/sbcl/$1"
		shift
 	    done
	    ;;
    install-defsystem | install-clc)
	    echo $0 loading and dumping clc.
	    ( cd /usr/lib/sbcl
	      sbcl --core /usr/lib/sbcl/sbcl-dist.core \
		   --noinform --sysinit /etc/sbclrc --userinit /dev/null \
		   --load "/usr/lib/sbcl/install-clc.lisp" 2> /dev/null
              mv sbcl-new.core sbcl.core || (echo FAILED ; cp sbcl-dist.core sbcl.core ) )
	    ;;
    remove-defsystem | remove-clc)
	    echo $0 removing clc-enabled image
	    cp /usr/lib/sbcl/sbcl-dist.core /usr/lib/sbcl/sbcl.core
	    ;;
    make-user-image)
	if [ ! -f "$2" ] ; then 
	    echo "Trying to make-user image, but can not find file $2" >&2
	    exit 1
	fi 
	sbcl --core /usr/lib/sbcl/sbcl-dist.core \
	    --noinform --sysinit /dev/null --userinit /dev/null \
	    --eval \
"(handler-case
  (progn    
    (load \"$2\") 
    (sb-ext:gc :full t)
    (sb-ext:save-lisp-and-die \"/usr/lib/sbcl/sbcl-new.core\" :purify t))
    (sb-unix:unix-exit 0))
  (error (e)
    (ignore-errors (format t \"make-user-image error: ~A~%\" e))
    (finish-output)
    (sb-unix:unix-exit 1)))"
            mv sbcl-new.core sbcl.core || (echo FAILED ; cp sbcl-dist.core sbcl.core ) 
	    ;;
    *)
	    echo $0 unkown command $1
	    echo known commands: rebuild, remove, make-user-image, install-clc and remove-clc
	    exit 1
	    ;;
esac

exit 0
