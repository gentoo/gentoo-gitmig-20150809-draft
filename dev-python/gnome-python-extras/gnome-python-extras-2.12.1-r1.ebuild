# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python-extras/gnome-python-extras-2.12.1-r1.ebuild,v 1.1 2006/07/02 16:52:39 allanonjl Exp $

NEED_PYTHON=2.4

inherit eutils gnome2 python autotools

DESCRIPTION="GNOME 2 Bindings for Python"
HOMEPAGE="http://www.pygtk.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="doc firefox seamonkey"

RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.6
	>=dev-python/gnome-python-2.10
	>=dev-python/pygtk-2.4
	=gnome-extra/gtkhtml-2.6*
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=x11-libs/gtksourceview-1.1.90
	>=gnome-base/gnome-panel-2.10
	>=x11-libs/libwnck-2.9.92
	firefox? ( >=www-client/mozilla-firefox-1.0 )
	!firefox? ( seamonkey? ( >=www-client/seamonkey-1.0 ) )
	>=gnome-base/libgtop-2.9.5
	>=gnome-extra/nautilus-cd-burner-2.11.1
	>=gnome-extra/libgda-1.2.0
	>=app-text/gtkspell-2
	>=gnome-base/gconf-2.10
	media-video/totem
	"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper
	"

G2CONF=""
DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

src_unpack() {
	gnome2_src_unpack

	# change mozilla to seamonkey
	sed -i -e 's:1.2b):1.0.0):;s:mozilla):seamonkey):' configure.ac

	eautoreconf
}

src_compile() {

	# only controls linking, can't disable w/o a patch :)
	if use firefox; then
		G2CONF="${G2CONF} --with-gtkmozembed=firefox"
	else
		use seamonkey && G2CONF="${G2CONF} --with-gtkmozembed=seamonkey"
	fi

	gnome2_src_configure ${G2CONF}

	emake || die "make failed!"
}

src_install() {
	gnome2_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst() {
	python_version
	python_mod_optimize ${ROOT}/usr/$(get_libdir)/python${PYVER}/site-packages/gtk-2.0
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
