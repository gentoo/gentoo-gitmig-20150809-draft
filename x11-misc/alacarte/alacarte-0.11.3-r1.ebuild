# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alacarte/alacarte-0.11.3-r1.ebuild,v 1.8 2007/08/10 13:17:17 angelos Exp $

inherit gnome2 python eutils autotools

DESCRIPTION="Simple GNOME menu editor"
HOMEPAGE="http://www.realistanew.com/projects/alacarte"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
SLOT=0

RDEPEND=">=dev-lang/python-2.4
		 >=dev-python/pygtk-2.8
		 >=gnome-base/gnome-menus-2.18
		 >=dev-python/gnome-python-2.18"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	if ! built_with_use gnome-base/gnome-menus python ; then
		eerror "You must emerge gnome-base/gnome-menus with the python USE flag"
		die "alacarte needs python support in gnome-base/gnome-menus"
	fi
}

src_unpack() {
	gnome2_src_unpack

	epatch "${FILESDIR}"/${P}-python-2.5.patch

	eautoreconf
}
