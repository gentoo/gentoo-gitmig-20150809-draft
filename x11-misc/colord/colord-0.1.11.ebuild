# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/colord/colord-0.1.11.ebuild,v 1.1 2011/08/14 13:48:22 nirbheek Exp $

EAPI="4"

inherit autotools

DESCRIPTION="System service to accurately color manage input and output devices"
HOMEPAGE="http://www.freedesktop.org/software/colord/"
SRC_URI="http://www.freedesktop.org/software/colord/releases/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples +introspection scanner +udev vala"

REQUIRED_USE="vala? ( introspection )"

# XXX: raise to libusb-1.0.9:1 when available
COMMON_DEPEND="
	dev-db/sqlite:3
	>=dev-libs/glib-2.28.0:2
	>=dev-libs/libusb-1.0.8:1
	>=media-libs/lcms-2.2:2
	>=sys-auth/polkit-0.97
	introspection? ( >=dev-libs/gobject-introspection-0.9.8 )
	scanner? ( media-gfx/sane-backends )
	udev? ( || ( sys-fs/udev[gudev] sys-fs/udev[extras] ) )
"
RDEPEND="${COMMON_DEPEND}
	media-gfx/shared-color-profiles"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-sgml-utils
	dev-libs/libxslt
	>=dev-util/intltool-0.35
	dev-util/pkgconfig
	>=sys-devel/gettext-0.17
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.9 )
	vala? ( dev-lang/vala:0.12 )
"

# FIXME: needs pre-installed dbus service files
RESTRICT="test"

src_prepare() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"

	# Fix automagic vala
	epatch "${FILESDIR}/${PN}-0.1.11-fix-automagic-vala.patch"
	eautoreconf
}

src_configure() {
	econf \
		--disable-examples \
		--disable-static \
		--enable-polkit \
		--enable-reverse \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		$(use_enable scanner sane) \
		$(use_enable udev gudev) \
		$(use_enable vala) \
		VAPIGEN=$(type -p vapigen-0.12)
	# parallel make fails in doc/api
	use doc && MAKEOPTS=-j1
}

src_install() {
	default

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
	fi

	find "${D}" -name '*.la' -exec rm -f {} + || die
}
