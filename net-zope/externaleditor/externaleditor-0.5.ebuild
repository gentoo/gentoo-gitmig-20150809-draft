# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/externaleditor/externaleditor-0.5.ebuild,v 1.6 2004/06/25 01:20:09 agriffis Exp $

inherit zproduct

DESCRIPTION="Allows you to use your favorite editor(s) from ZMI."
HOMEPAGE="http://www.zope.org/Members/Caseman/ExternalEditor/"
SRC_URI="${HOMEPAGE}/ExternalEditor-${PV}.tgz
	${HOMEPAGE}/zopeedit-${PV}-src.tgz"
LICENSE="ZPL"
KEYWORDS="x86 ~ppc"

ZPROD_LIST="ExternalEditor"

src_install()
{
	dobin zopeedit.py
	rm -f zopeedit.py
	zproduct_src_install all
}

pkg_postinst()
{
	zproduct_pkg_postinst
	ewarn
	ewarn "To use the External Editor Zope Product you will need to manually"
	ewarn "configure the helper application(/usr/bin/zopeedit.py) for your"
	ewarn "browser. Read the documention for ExternalEditor."
}
