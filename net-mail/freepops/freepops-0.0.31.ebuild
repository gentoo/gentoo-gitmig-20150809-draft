# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/freepops/freepops-0.0.31.ebuild,v 1.2 2005/08/14 13:07:20 vapier Exp $

inherit eutils

DESCRIPTION="WebMail->POP3 converter and more"
HOMEPAGE="http://freepops.sourceforge.net/"
SRC_URI="mirror://sourceforge/freepops/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc"

RDEPEND=">=net-misc/curl-7.10.8"
DEPEND="${RDEPEND}
	doc? (
		>=app-doc/doxygen-1.3
		app-text/tetex
		virtual/ghostscript
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.0.31-srcmake.patch
}

src_compile() {
	./configure.sh linux || die "configure failed"
	emake -j1 all WHERE=/usr/ || die "make failed"
	if use doc ; then
		emake -j1 doc || die "make doc failed"
	fi
}

src_install() {
	make install DESTDIR="${D}" WHERE=/usr/ || die
	dodoc AUTHORS README ChangeLog TODO \
		"${D}"/usr/share/doc/${PN}/*
	rm -rf "${D}"/usr/share/doc/${PN}
	if use doc; then
		mv doc/manual/html-manual "${D}/usr/share/doc/${PF}"
	fi

	newinitd buildfactory/freePOPsd.initd freepopsd
	newconfd buildfactory/freePOPsd.confd freepopsd
}
