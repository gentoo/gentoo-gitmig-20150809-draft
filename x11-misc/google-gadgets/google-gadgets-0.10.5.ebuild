# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/google-gadgets/google-gadgets-0.10.5.ebuild,v 1.3 2009/02/05 03:03:32 ranger Exp $

EAPI=2

inherit base autotools multilib eutils fdo-mime

MY_PN=${PN}-for-linux
MY_P=${MY_PN}-${PV}
DESCRIPTION="Cool gadgets from Google for your Desktop"
HOMEPAGE="http://code.google.com/p/google-gadgets-for-linux/"
SRC_URI="http://${MY_PN}.googlecode.com/files/${MY_P}.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+dbus debug +gtk +qt4 +gstreamer networkmanager startup-notification"

# Weird things happen when we start mix-n-matching, so for the time being
# I've just locked the deps to the versions I had as of Summer 2008. With any
# luck, they'll be stable when we get to stabling this package.

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	>=dev-libs/libxml2-2.6.32
	sys-libs/zlib
	net-libs/xulrunner:1.9
	dbus? ( sys-apps/dbus )
	gstreamer? ( >=media-libs/gstreamer-0.10.19
			>=media-libs/gst-plugins-base-0.10.19 )

	gtk? ( dbus? ( >=dev-libs/dbus-glib-0.74 )
		>=x11-libs/cairo-1.6.4
		>=x11-libs/gtk+-2.12.10
		>=x11-libs/pango-1.20.3
		gnome-base/librsvg
		>=net-misc/curl-7.18.2
		>=dev-libs/atk-1.22.0 )

	networkmanager? ( net-misc/networkmanager )
	startup-notification? ( x11-libs/startup-notification )

	qt4? ( dbus? ( >=x11-libs/qt-dbus-4.4.0 )
		>=x11-libs/qt-core-4.4.0
		>=x11-libs/qt-webkit-4.4.0
		>=x11-libs/qt-xmlpatterns-4.4.0
		>=x11-libs/qt-opengl-4.4.0
		>=x11-libs/qt-script-4.4.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20"

S="${WORKDIR}/${MY_P}"

RESTRICT="test"

pkg_setup() {

	# If a non-google, non-qt4 and non-gtk host system for google-gadgets is ever developed,
	# I'll consider changing the error below.
	if ! use gtk && ! use qt4
	then
		eerror "You must choose which toolkit to build for. Either qt4 or gtk can be"
		eerror "chosen. For qt4, see also above. To enable \$toolkit, do:"
		eerror "echo \"${CATEGORY}/${PN} \$toolkit\" >> /etc/portage/package.use"
		die "You need to choose a toolkit"
	fi

	if ! use gstreamer
	then
		ewarn "Disabling gstreamer disables the multimedia functions of ${PN}."
		ewarn "This is not recommended. To enable gstreamer, do:"
		ewarn "echo \"${CATEGORY}/${PN} gstreamer\" >> /etc/portage/package.use"
	fi

}

src_unpack() {
	base_src_unpack
	cd "${S}"

	sed -i -r \
		-e '/^GGL_SYSDEPS_INCLUDE_DIR/ c\GGL_SYSDEPS_INCLUDE_DIR=$GGL_INCLUDE_DIR' \
		configure.ac||die "404"
	eautoreconf
}

src_configure() {
	#For the time being, the smjs-script runtime is required for both gtk and qt
	#versions, but the goal is to make the qt4 version depend only on qt-script.
	has_pkg_smjs=no \
	econf	--disable-dependency-tracking \
		--disable-update-desktop-database \
		--disable-update-mime-database \
		--disable-werror \
		--enable-libxml2-xml-parser \
		--enable-smjs-script-runtime \
		--with-gtkmozembed=libxul \
		--with-smjs-cppflags=-I/usr/include/nspr \
		--with-smjs-libdir=/usr/$(get_libdir)/xulrunner-1.9 \
		--with-smjs-incdir=/usr/include/xulrunner-1.9/unstable \
		--with-browser-plugins-dir=/usr/$(get_libdir)/nsbrowser/plugins \
		--with-oem-brand=Gentoo \
		$(use_enable debug) \
		$(use_enable dbus libggadget-dbus) \
		$(use_enable gstreamer gst-audio-framework) \
		$(use_enable gstreamer gst-mediaplayer-element) \
		$(use_enable gtk gtk-host) \
		$(use_enable gtk libggadget-gtk ) \
		$(use_enable gtk gtkmoz-browser-element) \
		$(use_enable gtk gtk-flash-element) \
		$(use_enable gtk gtk-system-framework) \
		$(use_enable gtk curl_xml_http_request) \
		$(use_enable qt4 qt-host) \
		$(use_enable qt4 libggadget-qt) \
		$(use_enable qt4 qt-system-framework) \
		$(use_enable qt4 qtwebkit-browser-element) \
		$(use_enable qt4 qt-xml-http-request) \
		$(use_enable qt4 qt-script-runtime) \
		|| die "econf failed"
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
