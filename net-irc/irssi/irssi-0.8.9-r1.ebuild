# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-0.8.9-r1.ebuild,v 1.1 2004/07/23 22:39:14 swegener Exp $

IUSE="nls ipv6 perl ssl socks5"

inherit perl-module eutils

DESCRIPTION="A modular textUI IRC client with IPv6 support."
SRC_URI="http://irssi.org/files/${P}.tar.bz2"
HOMEPAGE="http://irssi.org/"

RDEPEND="!net-irc/irssi-cvs
	>=dev-libs/glib-2.2.1
	sys-libs/ncurses
	ssl? ( dev-libs/openssl )
	perl? ( dev-lang/perl )
	socks5? ( >=net-misc/dante-1.1.13 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="GPL-2"
# Original KEYWORDS="x86 ppc sparc alpha hppa ~mips amd64 ia64 ppc64 s390"
# All other KEYWORDS were removed because this ebuild only contains an 64-bit arch fix.
KEYWORDS="amd64 ia64 ppc64"

src_unpack() {
	unpack ${A}

	# Ugly hack to work around compression of the html files.
	# Remove this if prepalldocs is changed to avoid gzipping html files.
	cd ${S} && \
	sed -i \
		-e 's/[^ 	]\+\.html//g' docs/Makefile.in || \
			die "sed doc/Makefile.in failed"

	epatch ${FILESDIR}/${P}-64bit-exec-fix.patch
}

src_compile() {
	# Note: there is an option to build a GUI for irssi, but according
	# to the website the GUI is no longer developed, so that option is
	# not used here.
	local myconf="--with-glib2 --without-servertest --with-proxy --with-ncurses"

	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_with perl`"
	myconf="${myconf} `use_enable ipv6`"
	myconf="${myconf} `use_with socks5 socks`"
	if use ssl; then
		myconf="${myconf} --with-openssl-include=/usr --with-openssl-libs=/usr"
	else
		myconf="${myconf} --disable-ssl"
	fi

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	myflags=""

	if use perl; then
		cd ${S}/src/perl/common; perl-module_src_prep
		cd ${S}/src/perl/irc;    perl-module_src_prep
		cd ${S}/src/perl/textui; perl-module_src_prep
		cd ${S}/src/perl/ui;     perl-module_src_prep
		cd ${S}
	fi

	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		gnulocaledir=${D}/usr/share/locale \
		${myflags} \
		install || die

	prepalldocs
	dodoc AUTHORS ChangeLog README TODO NEWS
	cd ${S}/docs
	dohtml -r . || die "dohtml failed"
}
