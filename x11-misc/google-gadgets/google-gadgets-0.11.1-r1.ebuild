# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/google-gadgets/google-gadgets-0.11.1-r1.ebuild,v 1.4 2010/11/08 04:29:18 jer Exp $

EAPI=2

inherit base autotools multilib eutils fdo-mime

MY_PN=${PN}-for-linux
MY_P=${MY_PN}-${PV}

DESCRIPTION="Cool gadgets from Google for your Desktop"
HOMEPAGE="http://code.google.com/p/google-gadgets-for-linux/"
SRC_URI="http://${MY_PN}.googlecode.com/files/${MY_P}.tar.bz2
	mirror://gentoo/${P}-gtk+-2.18.patch.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE="+dbus debug +gtk +qt4 +gstreamer networkmanager soup startup-notification webkit +xulrunner"

# Weird things happen when we start mix-n-matching, so for the time being
# I've just locked the deps to the versions I had as of Summer 2008. With any
# luck, they'll be stable when we get to stabling this package.

RDEPEND="
	>=dev-libs/libxml2-2.6.32
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	dbus? ( sys-apps/dbus )
	gstreamer? (
		>=media-libs/gstreamer-0.10.19
		>=media-libs/gst-plugins-base-0.10.19
	)
	gtk? (
		>=dev-libs/atk-1.22.0
		gnome-base/librsvg
		>=net-misc/curl-7.18.2
		>=x11-libs/cairo-1.6.4
		>=x11-libs/gtk+-2.12.10
		>=x11-libs/pango-1.20.3
		dbus? ( >=dev-libs/dbus-glib-0.74 )
	)
	networkmanager? ( net-misc/networkmanager )
	qt4? (
		>=x11-libs/qt-core-4.4.0
		>=x11-libs/qt-opengl-4.4.0
		>=x11-libs/qt-script-4.4.0
		>=x11-libs/qt-webkit-4.4.0
		>=x11-libs/qt-xmlpatterns-4.4.0
		dbus? ( >=x11-libs/qt-dbus-4.4.0 )
	)
	soup? ( >=net-libs/libsoup-2.26 )
	startup-notification? ( x11-libs/startup-notification )
	webkit? ( >=net-libs/webkit-gtk-1.0.3 )
	xulrunner? ( net-libs/xulrunner:1.9 )
"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20
"

S="${WORKDIR}/${MY_P}"

RESTRICT="test"

pkg_setup() {
	# If a non-google, non-qt4 and non-gtk host system for google-gadgets is ever developed,
	# I'll consider changing the error below.
	if ! use gtk && ! use qt4; then
		eerror "You must choose which toolkit to build for. Either qt4 or gtk can be"
		eerror "chosen. For qt4, see also above. To enable \$toolkit, do:"
		eerror "echo \"${CATEGORY}/${PN} \$toolkit\" >> /etc/portage/package.use"
		die "You need to choose a toolkit"
	fi

	if ! use gstreamer; then
		ewarn "Disabling gstreamer disables the multimedia functions of ${PN}."
		ewarn "This is not recommended. To enable gstreamer, do:"
		ewarn "echo \"${CATEGORY}/${PN} gstreamer\" >> /etc/portage/package.use"
	fi
}

src_prepare() {
	epatch "${DISTDIR}"/${P}-gtk+-2.18.patch.bz2

	# http://code.google.com/p/google-gadgets-for-linux/issues/detail?id=352
	# recommends CXXFLAGS="-Wno-invalid-offsetof", apparently we do not
	# need it on Gentoo
	epatch "${FILESDIR}"/${P}-xulrunner-1.9.2.patch

	sed -i -r \
		-e '/^GGL_SYSDEPS_INCLUDE_DIR/ c\GGL_SYSDEPS_INCLUDE_DIR=$GGL_INCLUDE_DIR' \
		configure.ac||die "404"
	eautoreconf
}

src_configure() {
	local myconf="--disable-dependency-tracking \
		--disable-update-desktop-database \
		--disable-update-mime-database \
		--disable-werror \
		--enable-libxml2-xml-parser \
		--with-browser-plugins-dir=/usr/$(get_libdir)/nsbrowser/plugins \
		--with-ssl-ca-file=/etc/ssl/certs/ca-certificates.crt \
		--with-oem-brand=Gentoo \
		$(use_enable debug) \
		$(use_enable dbus libggadget-dbus) \
		$(use_enable gstreamer gst-audio-framework) \
		$(use_enable gstreamer gst-video-element) \
		$(use_enable soup soup-xml-http-request) \
		$(use_enable webkit webkit-script-runtime) \
		$(use_enable webkit gtkwebkit-browser-element) \
		$(use_enable gtk gtk-host) \
		$(use_enable gtk libggadget-gtk ) \
		$(use_enable gtk gtk-edit-element) \
		$(use_enable gtk gtk-flash-element) \
		$(use_enable gtk gtk-system-framework) \
		$(use_enable gtk curl_xml_http_request) \
		$(use_enable qt4 qt-host) \
		$(use_enable qt4 libggadget-qt) \
		$(use_enable qt4 qt-edit-framework) \
		$(use_enable qt4 qt-system-framework) \
		$(use_enable qt4 qtwebkit-browser-element) \
		$(use_enable qt4 qt-xml-http-request) \
		$(use_enable qt4 qt-script-runtime)"
	if use xulrunner; then
		myconf="${myconf} \
			$(use_enable gtk gtkmoz-browser-element) \
			--with-gtkmozembed=libxul \
			--enable-smjs-script-runtime \
			--with-smjs-cppflags=-I/usr/include/nspr \
			--with-smjs-libdir=/usr/$(get_libdir)/xulrunner-1.9 \
			--with-smjs-incdir=/usr/include/xulrunner-1.9/unstable"
	else
		myconf="${myconf} --disable-gtkmoz-browser-element"
	fi

	econf ${myconf}
}

src_test() {
	#If someone wants to guarantee that emake will not make
	#tests fail promiscuosly, please do, otherwise we're using make.
	make check &> "${WORKDIR}"/check
}

src_install() {
	base_src_install
	dodoc ChangeLog README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
