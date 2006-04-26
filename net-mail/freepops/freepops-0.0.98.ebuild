# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/freepops/freepops-0.0.98.ebuild,v 1.1 2006/04/26 02:33:15 dragonheart Exp $

inherit eutils

DESCRIPTION="WebMail->POP3 converter and more"
HOMEPAGE="http://freepops.sourceforge.net/"
SRC_URI="mirror://sourceforge/freepops/${P}.tar.gz
		mirror://gentoo/${P}-luaupdates.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc gnutls"

RDEPEND=">=net-misc/curl-7.10.8
		gnutls? ( net-libs/gnutls )
		!gnutls? ( dev-libs/openssl )
		dev-lang/lua"
DEPEND="${RDEPEND}
	doc? (
		>=app-doc/doxygen-1.3
		app-text/tetex
		virtual/ghostscript
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.0.97-system-lua.patch"
}

src_compile() {
	# note fbsd and Darwin and osx targets exist here too
	if use gnutls; then
		./configure.sh linux-gnutls || die "configure gnutls failed"
	else
		./configure.sh linux || die "configure openssl failed"
	fi
	sed -i -e '/^WHERE=/s/=.*$/=\/usr\//' config
	emake -j1 all || die "make failed"
	if use doc ; then
		emake -j1 doc || die "make doc failed"
	fi
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS README ChangeLog TODO \
		"${D}"/usr/share/doc/${PN}/*
	rm -rf "${D}"/usr/share/doc/${PN}
	if use doc; then
		mv doc/manual/html-manual "${D}/usr/share/doc/${PF}"
	fi

	newinitd buildfactory/freePOPsd.initd freepopsd
	newconfd buildfactory/freePOPsd.confd freepopsd
}
