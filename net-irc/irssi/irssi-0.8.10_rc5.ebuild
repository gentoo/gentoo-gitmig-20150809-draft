# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-0.8.10_rc5.ebuild,v 1.2 2004/10/31 23:37:05 kito Exp $

inherit perl-module eutils

MY_P="${P//_/-}"

DESCRIPTION="A modular textUI IRC client with IPv6 support."
SRC_URI="http://irssi.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://irssi.org/"
IUSE="nls ipv6 perl ssl socks5"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ~ppc64 ~s390 ~ppc-macos"

# Block net-irc/irssi-charconv and net-irc/irssi-recode as
# their features have been integrated into Irssi itself.
RDEPEND="!net-irc/irssi-cvs
	!net-irc/irssi-charconv
	!net-irc/irssi-recode
	>=dev-libs/glib-2.2.1
	sys-libs/ncurses
	ssl? ( dev-libs/openssl )
	perl? ( dev-lang/perl )
	socks5? ( >=net-misc/dante-1.1.13 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=sys-apps/sed-4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Ugly hack to work around compression of the html files.
	# Remove this if prepalldocs is changed to avoid gzipping html files.
	sed -i \
		-e 's/[^ 	]\+\.html//g' docs/Makefile.in || \
			die "sed doc/Makefile.in failed"
}

src_compile() {
	if use ssl
	then
		myconf="--with-openssl-include=/usr --with-openssl-libs=/usr"
	else
		myconf="--disable-ssl"
	fi

	econf \
		--with-glib2 \
		--without-servertest \
		--with-proxy \
		--with-ncurses \
		$(use_enable nls) \
		$(use_with perl) \
		$(use_enable ipv6) \
		$(use_with socks5 socks) \
		${myconf} || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	if use perl
	then
		for dir in ${S}/src/perl/{common,irc,textui,ui}
		do
			cd ${dir}
			perl-module_src_prep
		done
		cd ${S}
	fi

	make \
		DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		gnulocaledir=${D}/usr/share/locale \
		install || die "make install failed"

	prepalldocs
	dodoc AUTHORS ChangeLog README TODO NEWS
	dohtml -r ${S}/docs/. || die "dohtml failed"
}
