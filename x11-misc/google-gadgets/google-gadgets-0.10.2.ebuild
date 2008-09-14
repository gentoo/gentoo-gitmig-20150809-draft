# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/google-gadgets/google-gadgets-0.10.2.ebuild,v 1.1 2008/09/14 15:41:29 loki_val Exp $

EAPI=1

inherit base eutils fdo-mime

MY_PN=${PN}-for-linux
MY_P=${MY_PN}-${PV}
DESCRIPTION="Cool gadgets from Google for your Desktop"
HOMEPAGE="http://code.google.com/p/google-gadgets-for-linux/"
SRC_URI="http://${MY_PN}.googlecode.com/files/${MY_P}.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dbus debug +gtk +qt4 +gstreamer"

# Weird things happen when we start mix-n-matching, so for the time being
# I've just locked the deps to the versions I had as of Summer 2008. With any
# luck, they'll be stable when we get to stabling this package.

# FIXME: ggl doesn't work with xulrunner:1.9. The other options are
# firefox-3 xulrunner and firefox-2. I was bitten by the fact that the configure
# scripts indicate that xulrunner-1.9 is supported and so couldn't get this
# POS software to run. It took me a couple of compiles to figure out what was
# broken. For now, I've just locked the dep to xulrunner:1.8, since I'm a lazy
# bastard.

RDEPEND=">=dev-lang/spidermonkey-1.7.0
	x11-libs/libX11
	x11-libs/libXext
	>=dev-libs/libxml2-2.6.32
	sys-libs/zlib

	dbus? ( sys-apps/dbus )

	gstreamer? (	>=media-libs/gstreamer-0.10.19
			>=media-libs/gst-plugins-base-0.10.19 )

	gtk? (	dbus? ( >=dev-libs/dbus-glib-0.74 )
		>=x11-libs/cairo-1.6.4
		>=x11-libs/gtk+-2.12.10
		>=x11-libs/pango-1.20.3
		gnome-base/librsvg
		net-libs/xulrunner:1.8
		>=net-misc/curl-7.18.2
		>=dev-libs/atk-1.22.0 )

	qt4? (	dbus? ( >=x11-libs/qt-dbus-4.4.0 )
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
		ewarn "Disabling gstreamer disables the  multimedia functions of ${PN}."
		ewarn "This is not recommended. To enable gstreamer, do:"
		ewarn "echo \"${CATEGORY}/${PN} gstreamer\" >> /etc/portage/package.use"
	fi

	if use gtk
	then
		if built_with_use net-misc/curl ssl
		then
			if built_with_use net-misc/curl nss || built_with_use net-misc/curl gnutls
			then
				curl_die
			else
				einfo "Congratulations! Your net-misc/curl is configured correctly to run"
				einfo "${PN}. Not many can say that."
			fi
		else
			curl_die
		fi
	fi
}

src_compile() {
	#For the time being, the smjs-script runtime is required for both gtk and qt
	#versions, but the goal is to make the qt4 version depend only on qt-script.

	econf	--disable-dependency-tracking \
		--disable-update-desktop-database \
		--disable-update-mime-database \
		--disable-werror \
		--enable-libxml2-xml-parser \
		--enable-smjs-script-runtime \
		--with-gtkmozembed=xulrunner \
		$(use_enable debug) \
		$(use_enable dbus libggadget-dbus) \
		$(use_enable gstreamer gst-audio-framework) \
		$(use_enable gstreamer gst-mediaplayer-element) \
		$(use_enable gtk gtk-host) \
		$(use_enable gtk libggadget-gtk ) \
		$(use_enable gtk gtkmoz-browser-element) \
		$(use_enable gtk gtk-system-framework) \
		$(use_enable gtk curl_xml_http_request) \
		$(use_enable qt4 qt-host) \
		$(use_enable qt4 libggadget-qt) \
		$(use_enable qt4 qt-system-framework) \
		$(use_enable qt4 qtwebkit-browser-element) \
		$(use_enable qt4 qt-xml-http-request) \
		$(use_enable qt4 qt-script-runtime) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_test() {
	#If someone wants to guarantee that emake will not make
	#tests fail promiscuosly, please do, otherwise we're using make.
	make check &> "${WORKDIR}"/check
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

curl_die() {
	eerror "net-misc/curl must be built with these use flags: ssl -gnutls -nss"
	eerror "to do so, do:"
	eerror 'echo "net-misc/curl ssl -gnutls -nss" >> /etc/portage/package.use'
	die "Your net-misc/curl was misconfigured."
}
