# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metacity/metacity-2.34.0.ebuild,v 1.1 2011/04/05 13:27:22 eva Exp $

EAPI="3"
# debug only changes CFLAGS
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="GNOME default window manager"
HOMEPAGE="http://blogs.gnome.org/metacity/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="test xinerama"

# XXX: libgtop is automagic, hard-enabled instead
RDEPEND=">=x11-libs/gtk+-2.20:2
	>=x11-libs/pango-1.2[X]
	>=gnome-base/gconf-2:2
	>=dev-libs/glib-2.6:2
	>=x11-libs/startup-notification-0.7
	>=x11-libs/libXcomposite-0.2
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXdamage
	x11-libs/libXcursor
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libSM
	x11-libs/libICE
	media-libs/libcanberra[gtk]
	gnome-base/libgtop
	gnome-extra/zenity
	xinerama? ( x11-libs/libXinerama )
	!x11-misc/expocity"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.8
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	test? ( app-text/docbook-xml-dtd:4.5 )
	xinerama? ( x11-proto/xineramaproto )
	x11-proto/xextproto
	x11-proto/xproto"

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README *.txt doc/*.txt"
	G2CONF="${G2CONF}
		--disable-static
		--enable-canberra
		--enable-compositor
		--enable-gconf
		--enable-render
		--enable-shape
		--enable-sm
		--enable-startup-notification
		--enable-xsync
		--with-gtk=2.0
		$(use_enable xinerama)"
}

src_prepare() {
	gnome2_src_prepare

	# Use sys/wait.h header instead of wait.h as described in posix specs,
	# bug 292009
	epatch "${FILESDIR}/${PN}-2.28.0-sys-wait-header.patch"

	# WIFEXITED and friends are defined in sys/wait.h
	# Fixes a build failure on BSD.
	# https://bugs.gentoo.org/show_bug.cgi?id=309443
	# https://bugzilla.gnome.org/show_bug.cgi?id=605460
	epatch "${FILESDIR}/${PN}-2.28.1-wif_macros.patch"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die
}
