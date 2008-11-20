# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/freepops/freepops-0.2.8.ebuild,v 1.2 2008/11/20 19:20:07 dragonheart Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="WebMail->POP3 converter and more"
HOMEPAGE="http://freepops.sourceforge.net/"
SRC_URI="mirror://sourceforge/freepops/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnutls"

DEPEND=">=net-misc/curl-7.10.8
		gnutls? ( net-libs/gnutls
					dev-libs/libgcrypt )
		!gnutls? ( dev-libs/openssl )
		>=dev-lang/lua-5.1.3[deprecated]"
RDEPEND="${DEPEND}
		sys-apps/debianutils"
# bug #247280 - freepops-updater-dialog requires the /bin/tempfile executable in the
# sys-apps/debianutils package
#	doc? ( app-text/ghostscript-gpl app-text/tetex )"

#pkg_setup() {
#	if has_version '>dev-lang/lua-5.1.3' && ! built_with_use dev-lang/lua deprecated; then
#		eerror 'This package uses the deprecated functions of lua'
#		die 'please compile dev-lang/lua with USE=deprecated'
#	fi
#}

src_prepare() {
	sed -i -e '/PKGCONFIG lua/s/5.1//g' configure.sh
	epatch "${FILESDIR}"/${PN}-0.2.3-pop3config.diff
}

src_configure() {
	tc-export CC CXX LD AR STRIP RANLIB
	# note fbsd and Darwin and osx targets exist here too
	if use gnutls; then
		./configure.sh linux-gnutls -lua || die "configure gnutls failed"
	else
		./configure.sh linux -lua || die "configure openssl failed"
	fi
	sed -i -e '/^WHERE=/s/=.*$/=\/usr\//' config
	sed -i -e 's:var/lib/:usr/share/:g' config.h Makefile
}

src_compile() {
	emake -j1 H= all || die "make failed"
	# Doesn't work
#	if use doc; then
#		cd doc/manual
#		emake -j1 pdf
#	fi
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die
	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${PF}
	dodoc AUTHORS README ChangeLog TODO

	newinitd buildfactory/gentoo/freePOPsd.initd freepopsd
	newconfd buildfactory/gentoo/freePOPsd.confd freepopsd
	domenu buildfactory/debian-ubuntu/freepops.desktop
	doicon modules/src/winsystray/freepops-32.xpm
	doicon modules/src/winsystray/freepops-16.xpm
}
