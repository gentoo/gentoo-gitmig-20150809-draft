# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-0.8.10_rc5-r1.ebuild,v 1.1 2005/01/21 18:12:08 swegener Exp $

inherit perl-module eutils

MY_P="${P//_/-}"

DESCRIPTION="A modular textUI IRC client with IPv6 support"
HOMEPAGE="http://irssi.org/"
SRC_URI="http://irssi.org/files/${MY_P}.tar.gz
	mirror://gentoo/${P}-CVS-20050121.patch.bz2
	http://dev.gentoo.org/~swegener/distfiles/${P}-CVS-20050121.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="nls ipv6 perl ssl socks5"

RDEPEND="!net-irc/irssi-cvs
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

	epatch ${WORKDIR}/${P}-CVS-20050121.patch
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
	dodoc AUTHORS ChangeLog README TODO NEWS || die "dodoc failed"
	dohtml -r ${S}/docs/. || die "dohtml failed"
}
