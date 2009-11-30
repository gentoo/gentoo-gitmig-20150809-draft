# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/exo/exo-0.3.105-r1.ebuild,v 1.4 2009/11/30 15:28:33 armin76 Exp $

EAPI=2
inherit xfconf python multilib

DESCRIPTION="Extensions, widgets and framework library with session management support"
HOMEPAGE="http://www.xfce.org/projects/exo"
SRC_URI="mirror://xfce/src/xfce/exo/0.3/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="debug hal libnotify python"

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
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF="--disable-static
		$(use_enable hal)
		$(use_enable libnotify notifications)
		$(use_enable python)"
	DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
	PATCHES=( "${FILESDIR}/${PN}-0.3.4-interix.patch"
		"${FILESDIR}/${P}-sync.patch" )
}

src_prepare() {
	xfconf_src_prepare
	rm py-compile
	touch py-compile
	chmod +x py-compile

	if [[ ${CHOST} == *-interix* ]] ; then
		# configure detects getmntent, which is false!
		export ac_cv_func_getmntent=no
	fi
}

pkg_postinst() {
	xfconf_pkg_postinst
	python_mod_optimize "$(python_get_sitedir)"
}

pkg_postrm() {
	xfconf_pkg_postrm
	python_mod_cleanup "$(python_get_sitedir)"
}
