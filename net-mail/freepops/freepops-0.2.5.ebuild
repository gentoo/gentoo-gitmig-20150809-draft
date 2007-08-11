# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/freepops/freepops-0.2.5.ebuild,v 1.4 2007/08/11 02:27:09 beandog Exp $

inherit eutils toolchain-funcs

DESCRIPTION="WebMail->POP3 converter and more"
HOMEPAGE="http://freepops.sourceforge.net/"
SRC_URI="mirror://sourceforge/freepops/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gnutls"

RDEPEND=">=net-misc/curl-7.10.8
		gnutls? ( net-libs/gnutls
					dev-libs/libgcrypt )
		!gnutls? ( dev-libs/openssl )
		>=dev-lang/lua-5.1"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/PKGCONFIG lua/s/5.1//g' configure.sh
	epatch "${FILESDIR}"/${PN}-0.2.3-pop3config.diff
}

src_compile() {
	tc-export CC CXX LD AR STRIP RANLIB
	# note fbsd and Darwin and osx targets exist here too
	if use gnutls; then
		./configure.sh linux-gnutls -lua || die "configure gnutls failed"
	else
		./configure.sh linux -lua || die "configure openssl failed"
	fi
	sed -i -e '/^WHERE=/s/=.*$/=\/usr\//' config
	sed -i -e 's:var/lib/:usr/share/:g' config.h Makefile
	emake -j1 H= all || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${PF}
	dodoc AUTHORS README ChangeLog TODO

	newinitd buildfactory/gentoo/freePOPsd.initd freepopsd
	newconfd buildfactory/gentoo/freePOPsd.confd freepopsd
	domenu buildfactory/debian-ubuntu/freepops.desktop
	doicon modules/src/winsystray/freepops-32.xpm
	doicon modules/src/winsystray/freepops-16.xpm
}
