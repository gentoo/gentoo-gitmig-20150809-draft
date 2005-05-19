# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-cvs/irssi-cvs-0.2.ebuild,v 1.13 2005/05/19 20:53:55 swegener Exp $

ECVS_SERVER="cvs.irssi.org:/home/cvs"
ECVS_MODULE="irssi"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
inherit perl-module cvs

DESCRIPTION="A modular textUI IRC client with IPv6 support."
HOMEPAGE="http://irssi.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha hppa ~mips ~amd64"
IUSE="ipv6 perl ssl"

RDEPEND=">=dev-libs/glib-2.2.1
	sys-libs/ncurses
	perl? ( dev-lang/perl )
	ssl? ( dev-libs/openssl )
	!net-irc/irssi
	!net-irc/irssi-svn"
DEPEND="${RDEPEND}
	www-client/lynx
	>=sys-devel/autoconf-2.58"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	# Fixes bug 27584
	export WANT_AUTOCONF=2.5

	# Note: there is an option to build a GUI for irssi, but according
	# to the website the GUI is no longer developed, so that option is
	# not used here.

	# Edit these if you like
	myconf="--with-glib2 --without-servertest --with-proxy --with-ncurses"

	#perl is auto-detected and must be explicitly disabled
	use perl || myconf="${myconf} --with-perl=no"

	#ipv6 needs to be explicitly enabled
	use ipv6 && myconf="${myconf} --enable-ipv6"

	#socks needs to be explicitly enabled
	#use socks && myconf="${myconf} --with-socks"

	#ssl is auto-detected and must be disabled explicitly
	use ssl || myconf="${myconf} --disable-ssl"

	cd ${S}
	./autogen.sh \
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

	use perl && fixlocalpod

	prepalldocs
	dodoc AUTHORS ChangeLog README TODO NEWS
	cd ${S}/docs
	dohtml -r . || die "dohtml failed"
}
