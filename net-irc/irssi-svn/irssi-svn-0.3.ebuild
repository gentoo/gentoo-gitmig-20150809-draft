# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-svn/irssi-svn-0.3.ebuild,v 1.18 2006/09/15 21:15:29 swegener Exp $

inherit subversion perl-app flag-o-matic

ESVN_REPO_URI="http://svn.irssi.org/repos/irssi/trunk"
ESVN_PROJECT="irssi"
ESVN_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="http://irssi.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="ipv6 perl ssl socks5"

RDEPEND="!net-irc/irssi
	>=dev-libs/glib-2.2.1
	sys-libs/ncurses
	ssl? ( dev-libs/openssl )
	perl? ( dev-lang/perl )
	socks5? ( >=net-proxy/dante-1.1.18 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	dev-lang/perl
	www-client/lynx
	>=sys-devel/autoconf-2.58"

src_unpack() {
	subversion_src_unpack
	# We need to create the ChangeLog here
	TZ=UTC svn log -v "${ESVN_REPO_URI}" >ChangeLog
}

src_compile() {
	# Irssi uses extern inlines and that needs at least -O
	is-flag "-O*" || append-flags -O

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
