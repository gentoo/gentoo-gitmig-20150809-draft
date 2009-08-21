# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/exo/exo-0.3.102.ebuild,v 1.3 2009/08/21 12:40:23 darkside Exp $

EAPI="2"

inherit xfconf python multilib

DESCRIPTION="Extensions, widgets and framework library with session management support"
# Can't find a better homepage
HOMEPAGE="http://www.xfce.org"
SRC_URI="http://archive.xfce.org/src/xfce/exo/0.3/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc hal libnotify python"

RDEPEND=">=dev-lang/perl-5.6
	dev-perl/URI
	>=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-4.6.1
	libnotify? ( x11-libs/libnotify )
	hal? ( sys-apps/hal )
	python? ( dev-python/pygtk )"
DEPEND="${RDEPEND}
	dev-util/intltool
	doc? ( dev-util/gtk-doc )"

pkg_setup() {
	XFCONF=" $(use_enable doc gtk-doc) $(use_enable hal)
		$(use_enable libnotify notifications) $(use_enable python)"
	DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
	PATCHES=("${FILESDIR}/exo-0.3.101-iocharset.patch")
}

src_prepare() {
	xfconf_src_prepare
	cd "${S}"
	rm py-compile
	touch py-compile
	chmod +x py-compile
}

pkg_postinst() {
	xfce4_pkg_postinst
	python_mod_optimize "$(python_get_sitedir)"
}

pkg_postrm() {
	xfce4_pkg_postrm
	python_mod_cleanup "$(python_get_sitedir)"
}
