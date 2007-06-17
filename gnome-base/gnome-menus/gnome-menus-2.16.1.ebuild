# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-menus/gnome-menus-2.16.1.ebuild,v 1.13 2007/06/17 15:25:00 dang Exp $

inherit eutils gnome2 python multilib

DESCRIPTION="The GNOME menu system, implementing the F.D.O cross-desktop spec"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.6
	>=gnome-base/gnome-vfs-2.8.2
	>=dev-lang/python-2.2
	dev-python/pygtk"
DEPEND="${RDEPEND}
	  sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

src_unpack() {
	gnome2_src_unpack

	# Add a couple of important LegacyDir entries. See bug #97839.
	epatch "${FILESDIR}"/${PN}-2.10.2-legacy_dirs.patch
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize ${ROOT}usr/$(get_libdir)/python*/site-packages
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup "${ROOT}"usr/$(get_libdir)/python*/site-packages
}
