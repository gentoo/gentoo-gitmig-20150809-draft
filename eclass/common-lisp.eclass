# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/common-lisp.eclass,v 1.2 2003/06/08 00:24:48 mkennedy Exp $
#
# Author Matthew Kennedy <mkennedy@gentoo.org>
#
# This eclass supports the common-lisp-controller installation of many
# Common Lisp libraries

ECLASS=common-lisp
INHERITED="$INHERITED $ECLASS"

CLPACKAGE=
DEPEND="dev-lisp/common-lisp-controller"

pkg_postinst() {
	/usr/sbin/register-common-lisp-source $CLPACKAGE
}

pkg_prerm() {
	/usr/sbin/unregister-common-lisp-source $CLPACKAGE
}

common-lisp-install() {
	insinto /usr/share/common-lisp/source/$CLPACKAGE
	doins $@
}

common-lisp-system-symlink() {
	dodir /usr/share/common-lisp/systems/`dirname $CLPACKAGE`
	if [ $# -eq 0 ]; then
		dosym /usr/share/common-lisp/source/$CLPACKAGE/$CLPACKAGE.asd \
			/usr/share/common-lisp/systems/$CLPACKAGE.asd
	else
		for p in $@ ; do
			dosym /usr/share/common-lisp/source/$CLPACKAGE/$p.asd \
				/usr/share/common-lisp/systems/$p.asd
		done
	fi
}
