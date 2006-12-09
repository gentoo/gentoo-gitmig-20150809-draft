# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-0.88.ebuild,v 1.2 2006/12/09 22:27:26 dirtyepic Exp $

inherit eutils

DESCRIPTION="MS-Explorer-like minimalist file manager for X"
HOMEPAGE="http://roland65.free.fr/xfe/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~ppc64"
IUSE="nls"

# only fox-1.4.x is compatible with this version of xfe...
DEPEND="=x11-libs/fox-1.4*"

WANT_FOX="1.4"

src_compile() {

	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS BUGS FAQ README TODO NEWS

}

pkg_postinst() {

	einfo
	einfo 	"Please delete your old Xfe registry files"
	einfo 	" (~/.foxrc/Xfe ~/.foxrc/Xfv and ~/.foxrc/Xfq)"
	einfo	"before using this XFE release"
	einfo

}
