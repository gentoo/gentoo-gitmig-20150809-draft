# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/yaz++/yaz++-0.9.ebuild,v 1.2 2005/07/19 21:05:42 robbat2 Exp $

inherit eutils

DESCRIPTION="C++ addon for the yaz development libraries"
HOMEPAGE="http://www.indexdata.dk/yazplusplus"
SRC_URI="http://ftp.indexdata.dk/pub/${PN}/${P}.tar.gz"

LICENSE="YAZ"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="dev-libs/yaz"
DEPEND="${RDEPEND}
		sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}
	autoconf || die "autoconf failed"
}

src_compile() {
	econf --enable-shared || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	docdir="/usr/share/doc/${PF}"
	make DESTDIR="${D}" docdir="${docdir}" install || die "einstall failed"
	docinto html
	mv -f ${D}${docdir}/*.{html,css,png} ${D}${docdir}/html/ || die "Failed to move HTML docs"
}
