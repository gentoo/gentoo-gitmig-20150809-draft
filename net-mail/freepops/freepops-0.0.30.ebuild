# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/freepops/freepops-0.0.30.ebuild,v 1.1 2005/07/01 10:19:14 dragonheart Exp $

inherit eutils

DESCRIPTION="WebMail->POP3 converter and more"
HOMEPAGE="http://freepops.sourceforge.net/"
SRC_URI="mirror://sourceforge/freepops/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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
	epatch "${FILESDIR}"/${PN}-0.0.27-initd.patch #86271
	chmod a+r $(find . -name '*.lua') doc/freepopsd.1 #89612
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
