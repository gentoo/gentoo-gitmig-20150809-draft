# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-2.12.1.ebuild,v 1.13 2009/03/11 19:34:01 dang Exp $

inherit gnome2 autotools

DESCRIPTION="C++ interface for GTK+2"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="2.4"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="accessibility doc examples"

RDEPEND=">=dev-cpp/glibmm-2.14.1
	>=x11-libs/gtk+-2.12
	>=dev-cpp/cairomm-1.1.12
	>=dev-libs/libsigc++-2.0
	accessibility? ( >=dev-libs/atk-1.9.1 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS CHANGES ChangeLog PORTING NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} \
			$(use_enable accessibility api-atkmm) \
			$(use_enable doc docs) \
			$(use_enable examples)
			$(use_enable examples demos)"
}

src_unpack() {
	gnome2_src_unpack

	# Fix build with gtk+-2.14
	epatch "${FILESDIR}/${PN}-2.12.7-gtk2_14-compatibility.patch"
}

pkg_postinst() {
	gnome2_pkg_postinst
	ewarn "If you've changed the accessability USE flag on gtkmm, you've"
	ewarn "silently broken ABI.  You will have to re-emerge everything that"
	ewarn "depends on gtkmm.  You can find those packages with either"
	ewarn "equery d or qdepends -Q"
}
