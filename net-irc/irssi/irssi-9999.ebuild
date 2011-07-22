# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-9999.ebuild,v 1.1 2011/07/22 02:07:05 binki Exp $

EAPI=4

inherit autotools perl-module subversion

ESVN_REPO_URI="http://svn.irssi.org/repos/irssi/trunk"
ESVN_PROJECT="irssi"
ESVN_BOOTSTRAP=""

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="http://irssi.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ipv6 perl ssl socks5"

RDEPEND="sys-libs/ncurses
	>=dev-libs/glib-2.2.1
	ssl? ( dev-libs/openssl )
	perl? ( dev-lang/perl )
	socks5? ( >=net-proxy/dante-1.1.18 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	>=sys-devel/autoconf-2.58
	dev-lang/perl
	www-client/lynx"
RDEPEND="${RDEPEND}
	perl? ( !net-im/silc-client )
	!net-irc/irssi-svn"

src_prepare() {
	TZ=UTC svn log -v "${ESVN_REPO_URI}" > "${S}"/ChangeLog || die
	sed -i -e /^autoreconf/d autogen.sh || die
	NOCONFIGURE=1 ./autogen.sh || die

	eautoreconf
}

src_configure() {
	econf \
		--with-proxy \
		--with-ncurses \
		--with-perl-lib=vendor \
		$(use_with perl) \
		$(use_with socks5 socks) \
		$(use_enable ssl) \
		$(use_enable ipv6)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF} \
		install

	use perl && fixlocalpod

	dodoc AUTHORS ChangeLog README TODO NEWS
}
