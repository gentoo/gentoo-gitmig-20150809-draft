# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/vilistextum/vilistextum-2.6.7.ebuild,v 1.3 2005/01/04 11:17:48 ka0ttic Exp $

inherit eutils

DESCRIPTION="Vilistextum is a html to ascii converter specifically programmed to get the best out of incorrect html."
HOMEPAGE="http://bhaak.dyndns.org/vilistextum/"
SRC_URI="http://bhaak.dyndns.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
#IUSE="unicode kde"
IUSE="unicode"
KEYWORDS="x86 ~sparc ~amd64"

DEPEND="virtual/libc"
# KDE support will be available once a version of kaptain in stable
#    kde? ( kde-misc/kaptain )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-use-glibc-iconv.diff
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
