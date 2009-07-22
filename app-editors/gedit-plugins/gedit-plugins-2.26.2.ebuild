# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit-plugins/gedit-plugins-2.26.2.ebuild,v 1.1 2009/07/22 18:28:43 mrpouet Exp $

EAPI="1"

inherit gnome2

MY_PV=${PV#*.}

DESCRIPTION="Offical plugins for gedit."
HOMEPAGE="http://live.gnome.org/GeditPlugins"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"

IUSE="bookmarks +bracketcompletion charmap +codecomment colorpicker +drawspaces +joinlines python +sessionsaver showtabbar smartspaces terminal"

RDEPEND=">=x11-libs/gtk+-2.14
	gnome-base/gconf
	>=x11-libs/gtksourceview-2.6
	>=app-editors/gedit-2.26.1
	python? (
	>=dev-python/pygobject-2.15.4
	>=dev-python/pygtk-2.12.0
	>=dev-python/pygtksourceview-2.2.0
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS NEWS"

pkg_setup()
{
	local myplugins=

	for plugin in ${IUSE/python}; do
		if use ${plugin/+}; then
			myplugins="${myplugins:+${myplugins},}${plugin/+}"
		fi
	done

	G2CONF="${G2CONF}
		--disable-dependency-tracking
		--with-plugins=${myplugins}
		$(use_enable python)"
}

src_test() {
	emake check || die "make check failed"
}
