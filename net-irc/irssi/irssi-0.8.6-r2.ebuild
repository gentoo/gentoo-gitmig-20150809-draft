# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-0.8.6-r2.ebuild,v 1.9 2003/06/19 21:55:11 msterret Exp $

IUSE="nls ipv6 perl"

inherit perl-module

DESCRIPTION="A modular textUI IRC client with IPv6 support."
SRC_URI="http://irssi.org/files/${P}.tar.bz2"
HOMEPAGE="http://irssi.org/"

DEPEND=">=dev-libs/glib-1.2
	sys-libs/ncurses
	>=sys-apps/sed-4
	perl? ( dev-lang/perl )" 
	#socks? ( >=net-misc/dante-1.1.13 )
RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha hppa ~mips"

src_unpack() {
	unpack ${A}

	# Ugly hack to work around compression of the html files.
	# Remove this if prepalldocs is changed to avoid gzipping html files.
	cd ${S} && \
	sed -i \
		-e 's/[^ 	]\+\.html//g' docs/Makefile.in || \
			die "sed doc/Makefile.in failed"
}

src_compile() {
	# Note: there is an option to build a GUI for irssi, but according
	# to the website the GUI is no longer developed, so that option is
	# not used here.
	
	# Edit these if you like
	myconf="--without-servertest --with-bot --with-proxy --with-ncurses"
	
	use nls || myconf="${myconf} --disable-nls"

	#perl is auto-detected and must be explicitly disabled
	use perl || myconf="${myconf} --with-perl=no"

	#ipv6 needs to be explicitly enabled
	use ipv6 && myconf="${myconf} --enable-ipv6"

	#socks needs to be explicitly enabled
	#use socks && myconf="${myconf} --with-socks"

	#ssl is auto-detected and must be disabled explicitly
	use ssl || myconf="${myconf} --disable-ssl"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		${myconf} || die "./configure failed"

	emake || die
}

src_install() {
	myflags=""

	use perl && ( \
		cd ${S}/src/perl/common
		perl-module_src_prep
		cd ${S}/src/perl/irc
		perl-module_src_prep
		cd ${S}/src/perl/textui
		perl-module_src_prep
		cd ${S}/src/perl/ui
		perl-module_src_prep
		cd ${S}
	)

	make DESTDIR=${D} \
		PREFIX=${D}/usr \
		docdir=/usr/share/doc/${PF} \
		gnulocaledir=${D}/usr/share/locale \
		${myflags} \
		install || die

	prepalldocs
	dodoc AUTHORS ChangeLog README TODO NEWS
	cd docs && \
		dohtml -r . || die "dohtml failed"
}
