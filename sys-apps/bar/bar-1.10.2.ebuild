# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bar/bar-1.10.2.ebuild,v 1.1 2004/12/06 17:57:44 ka0ttic Exp $

DESCRIPTION="Console Progress Bar"
HOMEPAGE="http://clpbar.sourceforge.net/"
SRC_URI="mirror://sourceforge/clpbar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="doc? ( >=app-doc/doxygen-1.3.5 )"

src_compile() {
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
	use doc && { emake doc || die "make doc failed" ; }
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS INSTALL PORTING ChangeLog || die "dodoc failed"
	if use doc ; then
		rm -f ${S}/doc/html/installdox
		cp -R ${S}/doc/html ${D}/usr/share/doc/${PF}/
	fi
}
