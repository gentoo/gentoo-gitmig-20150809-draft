# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-0.8.10-r3.ebuild,v 1.12 2007/01/07 16:38:57 swegener Exp $

inherit perl-app eutils flag-o-matic

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="http://irssi.org/"
SRC_URI="http://irssi.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="ipv6 perl ssl socks5"

RDEPEND="sys-libs/ncurses
	>=dev-libs/glib-2.2.1
	ssl? ( dev-libs/openssl )
	perl? ( dev-lang/perl )
	socks5? ( >=net-proxy/dante-1.1.18 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"
RDEPEND="${RDEPEND}
	perl? ( !net-im/silc-client )
	!net-irc/irssi-svn"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-dcc-segv.patch
}

src_compile() {
	econf \
		--with-proxy \
		--with-ncurses \
		--with-perl-lib=vendor \
		$(use_enable ssl) \
		$(use_with perl) \
		$(use_enable ipv6) \
		$(use_with socks5 socks) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	if use perl
	then
		for dir in "${S}"/src/perl/{common,irc,textui,ui}
		do
			cd "${dir}"
			perl-app_src_prep
		done
		cd "${S}"
	fi

	make \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF} \
		gnulocaledir="${D}"/usr/share/locale \
		install || die "make install failed"

	use perl && fixlocalpod

	dodoc AUTHORS ChangeLog README TODO NEWS || die "dodoc failed"
	dohtml -r "${S}"/docs/. || die "dohtml failed"
}
