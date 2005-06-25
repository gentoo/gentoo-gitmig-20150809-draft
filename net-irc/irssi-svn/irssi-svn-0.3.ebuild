# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-svn/irssi-svn-0.3.ebuild,v 1.9 2005/06/25 21:02:53 killerfox Exp $

inherit subversion perl-module

ESVN_REPO_URI="http://svn.irssi.org/repos/irssi/trunk/"
ESVN_PROJECT="irssi"
ESVN_BOOTSTRAP="./autogen.sh"

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="http://irssi.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~x86"
IUSE="ipv6 perl ssl"

RDEPEND=">=dev-libs/glib-2.2.1
	sys-libs/ncurses
	perl? ( dev-lang/perl )
	ssl? ( dev-libs/openssl )
	!net-irc/irssi
	!net-irc/irssi-cvs"
DEPEND="${RDEPEND}
	www-client/lynx
	>=sys-devel/autoconf-2.58"

src_compile() {
	# Irssi uses extern inlines and that needs at least -O
	is-flag "-O*" || append-flags -O

	export WANT_AUTOCONF=2.5

	econf \
		--with-proxy \
		--with-ncurses \
		$(use_with perl) \
		$(use_enable ipv6) \
		$(use_enable ssl) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	if use perl
	then
		for dir in "${S}"/src/perl/{common,irc,textui,ui}
		do
			cd "${dir}"
			perl-module_src_prep
		done
		cd "${S}"
	fi

	make \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF} \
		gnulocaledir="${D}"/usr/share/locale \
		install || die "make install failed"

	use perl && fixlocalpod

	prepalldocs
	dodoc AUTHORS ChangeLog README TODO NEWS
	dohtml -r "${S}"/docs/. || die "dohtml failed"
}
