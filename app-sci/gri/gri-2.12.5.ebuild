# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gri/gri-2.12.5.ebuild,v 1.1 2003/06/30 23:14:03 aliz Exp $

IUSE=""

DESCRIPTION="language for scientific graphics programming"
HOMEPAGE="http://gri.sourceforge.net/"
SRC_URI="mirror://sourceforge/gri/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=app-sci/netcdf-3.5.0"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	# Replace PREFIX now and correct paths in the startup message.
	mv ${S}/startup.msg ${S}/startup.msg.orig
	sed -e s,PREFIX/share/doc/gri/,/usr/share/doc/${P}/, ${S}/startup.msg.orig > ${S}/startup.msg

	einstall || die

	dodoc AUTHOR README
	#move docs to the proper place
	mv ${D}/usr/share/gri/doc/* ${D}/usr/share/doc/${PF}
	rmdir ${D}/usr/share/gri/doc/
}
