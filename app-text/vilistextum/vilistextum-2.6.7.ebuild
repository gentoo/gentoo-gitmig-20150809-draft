# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/vilistextum/vilistextum-2.6.7.ebuild,v 1.1 2005/01/01 19:31:56 ka0ttic Exp $

inherit eutils

DESCRIPTION="Vilistextum is a html to ascii converter specifically programmed to get the best out of incorrect html."
HOMEPAGE="http://bhaak.dyndns.org/vilistextum/"
SRC_URI="http://bhaak.dyndns.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="unicode kde"
KEYWORDS="~x86 ~sparc ~amd64"

DEPEND="virtual/libc
	kde? ( kde-misc/kaptain )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	use unicode && epatch ${FILESDIR}/${P}-use-glibc-iconv.diff
}

src_compile() {
	einfo "Running autoreconf"
	autoreconf -f -i || die "autoreconf failed"

	econf \
		$(use_enable unicode multibyte) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README CHANGES
	dohtml doc/*.{html,css}
}
