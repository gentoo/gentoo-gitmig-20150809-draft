# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/common-lisp-common.eclass,v 1.2 2004/01/28 09:33:09 mkennedy Exp $
#
# Author Matthew Kennedy <mkennedy@gentoo.org>
#
# Sundy code common to many Common Lisp related ebuilds.

do-debian-credits() {
	docinto debian
	for i in copyright README.Debian changelog; do
		dodoc ${S}/debian/${i}
	done
	docinto .
}

# Most of the code below is from Debian's Common Lisp Controller
# package

register-common-lisp-implementation() {
	PROGNAME=$(basename $0)
	# first check if there is at least a compiler-name:
	if [ -z "$1"  ] ; then
		cat <<EOF
usage: $PROGNAME compiler-name

registers a Common Lisp compiler to the
Common-Lisp-Controller system.
EOF
		exit 1
	fi
	IMPL=$1
	FILE="/usr/lib/common-lisp/bin/$IMPL.sh"
	if [ ! -f "$FILE" ] ; then
		cat <<EOF
$PROGNAME: I cannot find the script $FILE for the implementation $IMPL
EOF
		exit 2
	fi
	if [ ! -r "$FILE" ] ; then
		cat <<EOF
$PROGNAME: I cannot read the script $FILE for the implementation $IMPL
EOF
		exit 2
	fi
	# install CLC into the lisp
	sh "$FILE" install-clc || (echo "Installation of CLC failed" >&2 ; exit 3)
	mkdir /usr/lib/common-lisp/$IMPL || true &>/dev/null
	chown cl-builder:cl-builder /usr/lib/common-lisp/$IMPL

	# now recompile the stuff
	for i  in /usr/share/common-lisp/systems/*.asd	; do
		if [ -f $i -a -r $i ] ; then
			i=${i%.asd}
			package=${i##*/}
			clc-autobuild-check $IMPL $package
			if [ $? = 0 ]; then
				echo recompiling package $package for implementation $IMPL
				/usr/bin/clc-send-command --quiet recompile $package $IMPL
			fi
		fi
	done
	for i  in /usr/share/common-lisp/systems/*.system  ; do
		if [ -f $i -a -r $i ] ; then
			i=${i%.system}
			package=${i##*/}
			clc-autobuild-check $IMPL $package
			if [ $? = 0 ]; then
				echo recompiling package $package for implementation $IMPL
				/usr/bin/clc-send-command --quiet recompile $package $IMPL
			fi
		fi
	done
	echo "$PROGNAME: Compiler $IMPL installed"
}

unregister-common-lisp-implementation() {
	PROGNAME=$(basename $0)
	if [ `id -u` != 0 ] ; then
		echo $PROGNAME: you need to be root to run this program
		exit 1
	fi
	if [ -z "$1" ] ; then
		cat <<EOF
usage: $PROGNAME compiler-name

un-registers a Common Lisp compiler to the
Common-Lisp-Controller system.
EOF
		exit 1
	fi
	IMPL=$1
	IMPL_BIN="/usr/lib/common-lisp/bin/$IMPL.sh"
	if [ ! -f "$IMPL_BIN" ] ; then
		cat <<EOF
$PROGNAME: No implementation of the name $IMPL is registered
Cannot find the file $IMPL_BIN

Maybe you already removed it?
EOF
		exit 0
	fi
	if [ ! -r "$IMPL_BIN" ] ; then
		cat <<EOF
$PROGNAME: No implementation of the name $IMPL is registered
Cannot read the file $IMPL_BIN

Maybe you already removed it?
EOF
		exit 0
	fi
	# Uninstall the CLC
	sh $IMPL_BIN remove-clc || echo "De-installation of CLC failed" >&2
	clc-autobuild-impl $IMPL inherit
	# Just remove the damn subtree
	(cd / ; rm -rf "/usr/lib/common-lisp/$IMPL/" ; true )
	echo "$PROGNAME: Common Lisp implementation $IMPL uninstalled"
}

reregister-all-common-lisp-implementations() {
	# Rebuilds all common lisp implementations
	# Written by Kevin Rosenberg <kmr@debian.org>
	# GPL-2 license
	local clc_bin_dir=/usr/lib/common-lisp/bin
	shopt -s nullglob
	cd $clc_bin_dir
	for impl_bin in *.sh; do
		impl=$(echo $impl_bin | sed 's/\(.*\).sh/\1/')
		unregister-common-lisp-implementation $impl
		register-common-lisp-implementation $impl
	done
}



# Local Variables: ***
# mode: shell-script ***
# tab-width: 4 ***
# End: ***