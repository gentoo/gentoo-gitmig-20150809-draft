# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/common-lisp-common.eclass,v 1.1 2003/10/14 03:07:44 mkennedy Exp $
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

# Local Variables: ***
# mode: shell-script ***
# tab-width: 4 ***
# End: ***