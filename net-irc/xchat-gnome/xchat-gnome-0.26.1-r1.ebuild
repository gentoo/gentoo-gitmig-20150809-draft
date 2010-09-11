# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-gnome/xchat-gnome-0.26.1-r1.ebuild,v 1.2 2010/09/11 10:23:43 nixnut Exp $

EAPI="2"

inherit gnome2 eutils toolchain-funcs

DESCRIPTION="GNOME frontend for the popular X-Chat IRC client"
HOMEPAGE="http://xchat-gnome.navi.cx/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="dbus ipv6 libnotify mmx nls perl python sound spell ssl tcl"

RDEPEND=">=dev-libs/glib-2.18.0
	>=gnome-base/libgnome-2.16.0
	>=gnome-base/gconf-2.8.0
	>=gnome-base/libgnomeui-2.16.0
	>=gnome-base/libglade-2.3.2
	>=x11-libs/gtk+-2.14.0
	spell? ( app-text/enchant )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	perl? ( >=dev-lang/perl-5.6.1 )
	python? ( dev-lang/python )
	tcl? ( dev-lang/tcl )
	dbus? ( >=sys-apps/dbus-0.60 )
	>=x11-libs/libsexy-0.1.11
	libnotify? ( >=x11-libs/libnotify-0.3.2 )
	sound? ( >=media-libs/libcanberra-0.3[gtk] )
	x11-libs/libX11"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.7
	>=app-text/gnome-doc-utils-0.3.2
	nls? ( sys-devel/gettext )"

# gnome-base/gnome-common needed when doing eautoreconf

pkg_setup() {
	if [[ $(gcc-major-version) -lt 4 || (
		$(gcc-major-version) -eq 4 && $(gcc-minor-version) -lt 1 || (
			$(gcc-major-version) -eq 4 && $(gcc-minor-version) -eq 1 && $(gcc-micro-version) -lt 3 ) ) ]]; then
			ewarn "${P} requires >=sys-devel/gcc-4.1.3 to compile"
			die "Please select >=sys-devel/gcc-4.1.3"
	fi

	# Per configure.ac, shm is disable because of upstream bug #565958
	# --enable-shm
	G2CONF="${G2CONF}
		--enable-gnomefe
		--disable-schemas-install
		--disable-scrollkeeper
		--disable-static
		--disable-maintainer-mode
		$(use_enable ssl openssl)
		$(use_enable perl)
		$(use_enable python)
		$(use_enable tcl)
		$(use_enable mmx)
		$(use_enable ipv6)
		$(use_enable dbus)
		$(use_enable nls)
		$(use_enable sound canberra)
		$(use_enable libnotify notification)"
}

src_install() {
	gnome2_src_install

	# install plugin development header
	insinto /usr/include/xchat-gnome
	doins src/common/xchat-plugin.h || die "doins failed"

	dodoc AUTHORS ChangeLog NEWS || die "dodoc failed"
}
