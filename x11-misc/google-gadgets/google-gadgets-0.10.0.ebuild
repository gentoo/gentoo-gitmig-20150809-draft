# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/google-gadgets/google-gadgets-0.10.0.ebuild,v 1.1 2008/07/11 20:20:31 loki_val Exp $

EAPI=1

inherit base eutils

MY_PN=${PN}-for-linux
MY_P=${MY_PN}-${PV}
DESCRIPTION="Cool gadgets from Google for your Desktop"
HOMEPAGE="http://code.google.com/p/google-gadgets-for-linux/"
SRC_URI="http://${MY_PN}.googlecode.com/files/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dbus debug +gtk +qt4 +gstreamer"

# Weird things happen when we start mix-n-matching, so for the time being
# I've just locked the deps to the versions I have.
RDEPEND=">=dev-lang/spidermonkey-1.7.0
	x11-libs/libX11
	x11-libs/libXext
	>=dev-libs/libxml2-2.6.32
	>=sys-libs/zlib-1.2.3-r1

	dbus? ( sys-apps/dbus )

	gstreamer? (	>=media-libs/gstreamer-0.10.19
			>=media-libs/gst-plugins-base-0.10.19 )

	gtk? (	dbus? ( >=dev-libs/dbus-glib-0.74 )
		>=x11-libs/cairo-1.6.4
		>=x11-libs/gtk+-2.12.10
		>=x11-libs/pango-1.20.3
		>=net-libs/xulrunner-1.8.1.14
		>=net-misc/curl-7.18.1
		>=dev-libs/atk-1.22.0 )

	qt4? (	dbus? ( >=x11-libs/qt-dbus-4.4.0 )
		>=x11-libs/qt-core-4.4.0
		>=x11-libs/qt-webkit-4.4.0
		>=x11-libs/qt-xmlpatterns-4.4.0
		>=x11-libs/qt-opengl-4.4.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20"

S="${WORKDIR}/${MY_P}"

RESTRICT="test"

pkg_setup() {
	if ! use qt4
	then
		ewarn "Since >=x11-libs/qt-core-4.4.0 and related packages are package.masked"
		ewarn "pending updates to the tree, the qt4 backend for ${PN} will not be built"
		ewarn "unless you unmask the qt dependencies of this package and add"
		ewarn "${CATEGORY}/${PN} -qt4"
		ewarn "to /etc/portage/profile/package.use.mask"
	fi

	# If a non-google, non-qt4 and non-gtk host system for google-gadgets is ever developed,
	# I'll consider changing the error below.
	if ! use gtk && ! use qt4
	then
		eerror "You must choose which toolkit to build for. Either qt4 or gtk can be"
		eerror "chosen. For qt4, see also above. To enable $toolkit, do:"
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
	econf	--disable-dependecy-tracking \
		--disable-werror \
		--enable-libxml2-xml-parser \
		--enable-smjs-script-runtime \
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
		|| die "econf failed"
	emake || die "emake failed"
}

src_test() {
	make check &> "${WORKDIR}"/check
}

src_install() {
	base_src_install

	#Icon
	newicon resources/gadgets.png googlegadgets.png

	# Desktop entries
	if use gtk
	then
		make_desktop_entry "ggl-gtk" "Google Gadgets (GTK)" googlegadgets
		make_desktop_entry "ggl-gtk -s" "Google Gadgets (GTK sidebar)" googlegadgets
	fi

	if use qt4
	then
		make_desktop_entry "ggl-qt" "Google Gadgets (QT)" googlegadgets
	fi
}

curl_die() {
	eerror "net-misc/curl must be built with these use flags: ssl -gnutls -nss"
	eerror "to do so, do:"
	eerror 'echo "net-misc/curl ssl -gnutls -nss" >> /etc/portage/package.use'
	die "Your net-misc/curl was misconfigured."
}
