# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/exo/exo-0.6.0.ebuild,v 1.2 2011/01/16 18:43:52 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="python? 2"

inherit python xfconf

DESCRIPTION="Extensions, widgets and framework library with session management support"
HOMEPAGE="http://www.xfce.org/projects/exo/"
SRC_URI="mirror://xfce/src/xfce/exo/0.6/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="debug python"

RDEPEND=">=dev-lang/perl-5.6
	dev-perl/URI
	>=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/libxfce4util-4.8
	python? ( >=dev-python/pygtk-2.4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi

	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--disable-dependency-tracking
		--disable-static
		$(use_enable python)
		$(xfconf_use_debug)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
}

src_prepare() {
	rm -f py-compile
	ln -s $(type -P true) py-compile

	xfconf_src_prepare
}

pkg_postinst() {
	xfconf_pkg_postinst
	use python && python_mod_optimize exo-0.6 pyexo.py
}

pkg_postrm() {
	xfconf_pkg_postrm
	use python && python_mod_cleanup exo-0.6 pyexo.py
}
