# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/exo/exo-0.5.1.ebuild,v 1.1 2009/10/24 12:37:14 ssuominen Exp $

EAPI=2
inherit xfconf python

DESCRIPTION="Extensions, widgets and framework library with session management support"
HOMEPAGE="http://www.xfce.org/projects/exo"
SRC_URI="mirror://xfce/src/xfce/exo/0.5/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="debug hal libnotify python"

RDEPEND=">=dev-lang/perl-5.6
	dev-perl/URI
	>=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/libxfce4util-4.4.2
	libnotify? ( >=x11-libs/libnotify-0.4 )
	hal? ( >=sys-apps/hal-0.5.7 )
	python? ( dev-python/pygtk )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		--disable-static
		$(use_enable libnotify notifications)
		$(use_enable hal)
		$(use_enable python)
		$(use_enable debug)"
	DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
}

src_prepare() {
	xfconf_src_prepare
	rm -f py-compile
	ln -s $(type -P true) py-compile

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
