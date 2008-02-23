# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apachetop/apachetop-0.12.6.ebuild,v 1.9 2008/02/23 20:26:07 hollow Exp $

inherit eutils autotools

DESCRIPTION="A realtime Apache log analyzer"
HOMEPAGE="http://www.webta.org/projects/apachetop"
SRC_URI="http://www.webta.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ppc sparc x86"
IUSE="fam pcre adns"

DEPEND="fam? ( virtual/fam )
	pcre? ( dev-libs/libpcre )
	adns? ( net-libs/adns )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc41.patch
	epatch "${FILESDIR}"/${P}-configure.patch
	eautoreconf
}

src_compile() {
	econf --with-logfile=/var/log/apache2/access_log \
		$(use_with fam) \
		$(use_with pcre) \
		$(use_with adns) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
