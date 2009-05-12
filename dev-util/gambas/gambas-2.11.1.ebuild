# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-2.11.1.ebuild,v 1.2 2009/05/12 08:56:27 loki_val Exp $

EAPI="2"

inherit autotools eutils fdo-mime qt3 multilib toolchain-funcs

DESCRIPTION="Gambas is a free development environment based on a Basic interpreter with object extensions"
HOMEPAGE="http://gambas.sourceforge.net/"

SLOT="2"
MY_PN="${PN}${SLOT}"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="
	bzip2 corba curl debug doc examples firebird gtk kde mysql odbc opengl pcre
	pdf postgres qt3 sdl smtp sqlite sqlite3 svg v4l xml zlib
"

COMMON_DEPEND="
	bzip2?	( >=app-arch/bzip2-1.0.5 )
	corba?	( >=net-misc/omniORB-4.1.0 )
	curl?	( >=net-misc/curl-7.15.5-r1 )
	firebird?	( >=dev-libs/ibpp-2.5.3.1 )
	gtk?	(
		>=x11-libs/gtk+-2.10.14
		svg?	( >=gnome-base/librsvg-2.16.1-r2 )
	)
	mysql?	( >=virtual/mysql-5.0 )
	odbc?	( >=dev-db/unixODBC-2.2.12 )
	opengl?	( >=media-libs/mesa-7.0.2 )
	pcre?	( >=dev-libs/libpcre-7.6-r1 )
	pdf?	( >=virtual/poppler-0.5.3 )
	postgres?	( >=virtual/postgresql-base-8.2 )
	qt3?	(
		>=x11-libs/qt-3.2:3
		kde?	( >=kde-base/kdelibs-3.5.9-r1:3.5 )
	)
	sdl?	(
		>=media-libs/sdl-image-1.2.6-r1
		>=media-libs/sdl-mixer-1.2.7
	)
	smtp?	( >=dev-libs/glib-2.16.2 )
	sqlite?	( =dev-db/sqlite-2* )
	sqlite3?	( >=dev-db/sqlite-3.5.6 )
	v4l?	(
		>=media-libs/libpng-1.2.26
		>=media-libs/jpeg-6b-r8
	)
	xml?	(
		>=dev-libs/libxml2-2.6.31
		>=dev-libs/libxslt-1.1.22
	)
	zlib?	( >=sys-libs/zlib-1.2.3-r1 )
	sys-devel/gcc[libffi]
"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# ImageProvider implementers, see .component files for more info
	if ! { use qt3 || use gtk || use sdl; } ; then
		use pdf && die "PDF support depends on Qt, GTK or SDL being enabled"
		use v4l && die "V4L support depends on Qt, GTK or SDL being enabled"
	fi

	# OpenGLViewer implementers, see .component files for more info
	if ! { use qt3 || use sdl; } ; then
		use opengl && die "OpenGL support depends on Qt or SDL being enabled"
	fi

	if ! use gtk; then
		use svg && die "SVG support depends on GTK being enabled"
	fi

	if ! use qt3; then
		use kde && die "KDE support depends on Qt being enabled"

		einfo
		ewarn "The Gambas IDE currently cannot be be build without Qt being enabled."
		if use gtk; then
			einfo
			ewarn "You are using the USE flag gtk, but not qt3.  Attempting to use GTK instead"
			ewarn "of Qt for certain components.  This is considered EXPERIMENTAL and the"
			ewarn "resulting components may not function."
		fi
		einfo
		ebeep 3
	fi
}

my_reduce_eautoreconf() {
	sed -i -e "/^\(AC\|GB\)_CONFIG_SUBDIRS(${1}[,)]/d" \
	configure.ac \
	|| die "my_reduce_eautoreconf: sed on configure.ac failed with ${1}"

	sed -i -e "/^SUBDIRS/s/\ \(@${1}_dir@\|${1}\)//1" \
	Makefile.am \
	|| die "my_reduce_eautoreconf: sed on Makefile.am failed with ${1}"
}

my_examine_components() {
	local comp="gb.*/src/*.component gb.*/src/*/*.component main/lib/*/*.component comp/src/*/.component"

	# Examine app/src/gambas2/CComponent.class for more info
	echo
	einfo "Checking component files ..."
	einfo
	elog "The following components are reported stable, but incomplete:"
	elog "$(grep '^State=1' ${comp} | sed -e 's/.*\(gb\.[^/]*\)[/]\?\.component.*/\1/')"
	einfo
	ewarn "The following components are reported unstable:"
	ewarn "$(grep '^\(State=2\|Alpha\)' ${comp} | sed -e 's/.*\(gb\.[^/]*\)[/]\?\.component.*/\1/')"
	echo
}

src_prepare() {
	if { ! use qt3; } && use gtk; then
		ebegin "Applying sed no-Qt-use-GTK-workaround-patch (EXPERIMENTAL)"
		# Gentoo-specific patch/workaround
		sed -i -e 's/EXPORT = "gb.qt"/EXPORT = "gb.gtk"/' \
		main/lib/gui/main.c \
		|| die "sed no-Qt-use-GTK-workaround-patch (EXPERIMENTAL)"
		eend 0
	fi

	ebegin "Applying sed no-automagic-patch"
	# Gentoo-specific patch
	sed -i -e 's/gb_enable_\$1=yes/gb_enable_\$1=no/' \
	acinclude.m4 \
	|| die "sed no-automagic-patch failed"
	eend 0

	# Gentoo-specific patches for libtool compatibility
	epatch "${FILESDIR}/${PN}-2.7.0-r1-remove-libltdl-from-main.patch"
	epatch "${FILESDIR}/${PN}-2.8.0-libtool.patch"

	# Gentoo-specific patch
	epatch "${FILESDIR}/${PN}-2.8.2-FLAGS.patch"

	# Replacement for Gentoo-specific gambas-2.5.0-mimetype-registration.patch
	# submitted upstream
	epatch "${FILESDIR}/svn-r1636-xdg-utils.patch"

	epatch "${FILESDIR}/${PN}-2.9.0-app_Makefile.am.patch"
	epatch "${FILESDIR}/${PN}-2.9.0-comp_Makefile.am.patch"
	epatch "${FILESDIR}/${PN}-2.9.0-examples_Makefile.am.patch"
	epatch "${FILESDIR}/${PN}-2.9.0-help_Makefile.am.patch"
	epatch "${FILESDIR}/${PN}-2.9.0-main_Makefile.am.patch"
	epatch "${FILESDIR}/${PN}-2.9.0-component.am.patch"

	ebegin "Applying sed remove-dist_gblib_DATA-patch"
	# Prevent repeat installation of component files
	sed -i -e '/^dist_gblib_DATA/d' \
	component.am \
	main/lib/Makefile.am \
	|| die "sed remove-dist_gblib_DATA-patch failed"
	eend 0

	ebegin "Applying sed remove-libtool-patch"
	# Gentoo-specific patch, may be obsoleted in the future
	# Remove embedded libtool.m4 file
	sed -i -e '/[-][*][-]Autoconf[-][*][-]$/,$d' \
	acinclude.m4 \
	|| die "sed remove-libtool-patch failed"
	eend 0

	my_examine_components

	ebegin "Removing provided libtool/libltdl"
	rm -R ./main/libltdl \
	&& rm config.guess config.sub install-sh ltmain.sh \
	&& rm */config.guess */config.sub */install-sh */ltmain.sh \
	|| die "removing libtool failed"
	eend 0

	ebegin "Reducing eautoreconf"
	# Keep synchronized with myconf in src_compile
	use bzip2 ||	my_reduce_eautoreconf bzlib2
	use zlib ||	my_reduce_eautoreconf zlib
	use mysql ||	my_reduce_eautoreconf mysql
	use odbc ||	my_reduce_eautoreconf odbc
	use postgres ||	my_reduce_eautoreconf postgresql
	use sqlite ||	my_reduce_eautoreconf sqlite2
	use sqlite3 ||	my_reduce_eautoreconf sqlite3
	use firebird ||	my_reduce_eautoreconf firebird
	use gtk ||	my_reduce_eautoreconf gtk
	use svg ||	my_reduce_eautoreconf gtksvg
	use pdf ||	my_reduce_eautoreconf pdf
			#net
	use curl ||	my_reduce_eautoreconf curl
	use smtp ||	my_reduce_eautoreconf smtp
	use pcre ||	my_reduce_eautoreconf pcre
	use qt3 ||	my_reduce_eautoreconf qt
			my_reduce_eautoreconf qte
	use kde ||	my_reduce_eautoreconf kde
	use sdl ||	my_reduce_eautoreconf sdl
	use sdl ||	my_reduce_eautoreconf sdlsound
	use xml ||	my_reduce_eautoreconf xml
	use v4l ||	my_reduce_eautoreconf v4l
			#crypt
	use opengl ||	my_reduce_eautoreconf opengl
	use corba ||	my_reduce_eautoreconf corba
	{ use qt3 || use gtk || \
	use sdl; } ||	my_reduce_eautoreconf image
	use qt3 ||	my_reduce_eautoreconf desktop
	# This may work in the future, but it does not work now.
#	{ use qt3 || \
#	use gtk; } ||	my_reduce_eautoreconf desktop

	use doc ||	my_reduce_eautoreconf help
	use examples ||	my_reduce_eautoreconf examples
	eend 0

	eautoreconf || die "eautoreconf failed"
}

src_configure() {
	local myconf="
		$(use_enable bzip2 bzlib2)
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
		$( { use qt3 || use gtk || use sdl; } \
		&& echo '--enable-image' || echo '--disable-image')
		$(use_enable qt3 desktop)
	"
		# This may work in the future, but it does not work now.
#		$( { use qt3 || use gtk; } && echo '--enable-desktop' || echo '--disable-desktop')"

	myconf="${myconf}
		--enable-intl
		--enable-conv
		--enable-ffi
		--with-ffi-libraries=/usr/$(get_libdir)/gcc/${CHOST}/$(gcc-fullversion)
		--enable-preloading
		--disable-profiling
		$(use_enable debug)
		$(use_enable xml xslt)
	"
	if use qt3; then
		myconf="${myconf}
			$(use_enable opengl qtopengl)
			--enable-qt-translation
		"
		if use kde; then
			myconf="${myconf}
				--with-kde-includes=/usr/kde/3.5/include
				--with-kde-libraries=/usr/kde/3.5/$(get_libdir)
			"
		fi
	fi

	# --without-xdg-utils comes from svn-r1636-xdg-utils.patch
	econf --config-cache ${myconf} --without-xdg-utils \
	--docdir=/usr/share/doc/${PF} --htmldir=/usr/share/doc/${PF}/html
}

my_dekstop_and_icon() {
	# USAGE: <executable> <name> <category> <icon_source_file> <icon_target_dir>
	local icon="${1}.png"

	make_desktop_entry "${1}" "${2}" "${5}/${icon}" "${3}" \
	|| die "make_desktop_entry failed for ${1}"

	insinto ${5}
	newins ${4} ${icon} || die "newins failed for ${1}"
}

src_compile() {
	emake LIBTOOLFLAGS="--quiet" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" LIBTOOLFLAGS="--quiet" install -j1 || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
	newdoc gb.net/src/doc/README gb.net-README || die "newdoc failed"
	newdoc gb.net/src/doc/changes.txt gb.net-ChangeLog || die "newdoc failed"
	use pcre && { newdoc gb.pcre/src/README gb.pcre-README || die "newdoc failed"; }

	if { use qt3 || use gtk; } ; then
		# Remove qt3 test when it works without it
		use qt3 && \
		my_dekstop_and_icon \
		"${MY_PN}" "Gambas" "Development" \
		"app/src/${MY_PN}/img/logo/new-logo.png" \
		"/usr/share/icons/hicolor/128x128/apps"

		my_dekstop_and_icon \
		"${MY_PN}-database-manager" "Gambas Database Manager" "Development" \
		"app/src/${MY_PN}-database-manager/img/logo/logo-128.png" \
		"/usr/share/icons/hicolor/128x128/apps"

		insinto /usr/share/icons/hicolor/64x64/mimetypes
		doins app/mime/*.png main/mime/*.png || die "doins failed"

		insinto /usr/share/mime/application
		doins app/mime/*.xml main/mime/*.xml || die "doins failed"
	fi

	use doc && { dosym "/usr/share/${MY_PN}/help" "/usr/share/doc/${PF}/html" \
	|| die "dosym failed"; }
}

my_fdo_update() {
	{ use qt3 || use gtk; } && fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postinst() {
	my_fdo_update
}

pkg_postrm() {
	my_fdo_update
}
