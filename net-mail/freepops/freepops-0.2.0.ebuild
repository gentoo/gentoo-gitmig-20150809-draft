# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/freepops/freepops-0.2.0.ebuild,v 1.1 2007/03/05 12:31:44 dragonheart Exp $

inherit eutils

DESCRIPTION="WebMail->POP3 converter and more"
HOMEPAGE="http://freepops.sourceforge.net/"
SRC_URI="mirror://sourceforge/freepops/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnutls"

RDEPEND=">=net-misc/curl-7.10.8
		gnutls? ( net-libs/gnutls
					dev-libs/libgcrypt )
		!gnutls? ( dev-libs/openssl )
		>=dev-lang/lua-5.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/pkg-config lua/s/5.1//g' configure.sh
}

src_compile() {
	# note fbsd and Darwin and osx targets exist here too
	if use gnutls; then
		./configure.sh linux-gnutls -lua || die "configure gnutls failed"
		sed -i -e '/^WHERE=/s/=.*$/=\/usr\//' config
	else
		./configure.sh linux-slack -lua || die "configure openssl failed"
	fi
	emake -j1 all || die "make failed"
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die
	dodoc AUTHORS README ChangeLog TODO \
		"${D}"/usr/share/doc/${PN}/*
	rm -rf "${D}"/usr/share/doc/${PN}
	chmod a+x "${D}"/usr/bin/freepops-updater-dialog

	newinitd buildfactory/freePOPsd.initd freepopsd
	newconfd buildfactory/freePOPsd.confd freepopsd
}
