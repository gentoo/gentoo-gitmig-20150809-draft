# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-2.7.0.ebuild,v 1.1 2008/06/26 23:32:09 darkside Exp $

inherit autotools eutils qt3

MY_P="${PN}2-${PV}"

DESCRIPTION="Gambas is a free development environment based on a Basic interpreter with object extensions"
HOMEPAGE="http://gambas.sourceforge.net"

SRC_URI="mirror://sourceforge/gambas/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="2"

KEYWORDS="~x86"
IUSE="bzip2 corba curl firebird gtk kde mysql odbc opengl pcre pdf postgres qt3 sdl smtp sqlite sqlite3 svg v4l xml zlib"

DEPEND=""
RDEPEND="bzip2?	( >=app-arch/bzip2-1.0.5 )
	corba?	( >=net-misc/omniORB-4.1.0 )
	curl?	( >=net-misc/curl-7.15.5-r1 )
	firebird?	( >=dev-db/firebird-2.1.0.17755_rc2-r1 )
	gtk?	( >=x11-libs/gtk+-2.10.14 )
	kde?	( >=kde-base/kdelibs-3.5.9-r1 )
	mysql?	( >=virtual/mysql-5.0 )
	odbc?	( >=dev-db/unixODBC-2.2.12 )
	opengl?	( >=media-libs/mesa-7.0.2 )
	pcre?	( >=dev-libs/libpcre-7.6-r1 )
	pdf?	( >=app-text/poppler-0.5.3 )
	postgres?	( >=virtual/postgresql-base-8.2 )
	qt3?	( $(qt_min_version 3.2) )
	sdl?	( >=media-libs/sdl-image-1.2.6-r1 >=media-libs/sdl-mixer-1.2.7 )
	smtp?	( >=dev-libs/glib-2.16.2 )
	sqlite?	( =dev-db/sqlite-2* )
	sqlite3?	( >=dev-db/sqlite-3.5.6 )
	svg?	( >=gnome-base/librsvg-2.16.1-r2 )
	v4l?	( >=media-libs/libpng-1.2.26 >=media-libs/jpeg-6b-r8 )
	xml?	( >=dev-libs/libxml2-2.6.31 >=dev-libs/libxslt-1.1.22 )
	zlib?	( >=sys-libs/zlib-1.2.3-r1 )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ( !(built_with_use sys-devel/gcc libffi) ); then
	die "gcc needs to be build with the USE flag libffi"
	fi

	if ( !( use gtk ) ); then
	use svg && die "SVG support depends on GTK being enabled"
	fi

	ewarn
	ewarn "Your CFLAGS and LDFLAGS from make.conf are not handled correctly"
	ewarn "They are currently ignored and replaced with internal values"
	ewarn

	### v4l linux kernel support check needed?
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's/gb_enable_\$1=yes/gb_enable_\$1=no/' \
	acinclude.m4 \
	|| die "sed no-automagic-patch failed"

	sed -i -e 's/@QT_LDFLAGS@/\${QT_LDFLAGS}/' \
	gb.qt/src/Makefile.am \
	gb.qt/src/ext/Makefile.am \
	gb.qt/src/opengl/Makefile.am \
	|| die "sed qt_ldflags-patch failed"

	epatch "${FILESDIR}/${PN}-2.5.0-gcc-libffi-path.patch"
	epatch "${FILESDIR}/${PN}-2.5.0-sdl.patch"
	epatch "${FILESDIR}/${PN}-2.7.0-help-path.patch"
	epatch "${FILESDIR}/${PN}-2.5.0-mimetype-registration.patch"

	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	local myconf
	local myconf_main
	local myconf_qt
	local myconf_xml

	myconf="$(use_enable bzip2 bzlib2)
		$(use_enable zlib)
		$(use_enable mysql)
		$(use_enable odbc)
		$(use_enable postgres postgresql)
		$(use_enable sqlite sqlite2)
		$(use_enable sqlite3)
		$(use_enable firebird)
		$(use_enable gtk)
		$(use_enable svg gtksvg)
		$(use_enable pdf)
		--enable-net
		$(use_enable curl)
		$(use_enable smtp)
		$(use_enable pcre)
		$(use_enable qt3 qt)
		--disable-qte
		$(use_enable kde)
		$(use_enable sdl)
		$(use_enable sdl sdlsound)
		$(use_enable xml)
		$(use_enable v4l)
		--enable-crypt
		$(use_enable opengl)
		$(use_enable corba)
		--enable-image
		--enable-desktop"

	myconf_main="--enable-intl
	--enable-conv
	--enable-ffi
	--enable-preloading"

	if (use qt); then
		myconf_qt="$(use_enable opengl qtopengl)
		--enable-qt-translation	"
	fi

	myconf_xml="$(use_enable xml xslt)"

	econf ${myconf} ${myconf_main} ${myconf_qt} ${myconf_xml} \
	--enable-optimization --disable-debug --disable-profiling \
	--docdir=/usr/share/doc/${PF} --htmldir=/usr/share/doc/${PF}/html \
	|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install -j1 || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}

pkg_postinst() {
	ewarn
	ewarn "This ebuild currently does not create menu items and does not handle Gambas"
	ewarn "mime installation correctly"
	ewarn
}
