# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-0.8.10_rc5.ebuild,v 1.4 2004/11/03 06:03:57 kito Exp $

inherit perl-module eutils

MY_P="${P//_/-}"

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="http://irssi.org/"
SRC_URI="http://irssi.org/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="nls ipv6 perl ssl socks5"

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
