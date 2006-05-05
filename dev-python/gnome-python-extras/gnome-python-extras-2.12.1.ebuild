# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python-extras/gnome-python-extras-2.12.1.ebuild,v 1.5 2006/05/05 17:32:40 corsair Exp $

inherit eutils gnome2 python

DESCRIPTION="GNOME 2 Bindings for Python"
HOMEPAGE="http://www.pygtk.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc firefox mozilla"

RDEPEND=">=virtual/python-2.4
	>=x11-libs/gtk+-2.4
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
	!firefox? ( mozilla? ( >=www-client/mozilla-1.2 ) )
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
USE_DESTDIR="1"
DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

src_compile() {

	# only controls linking, can't disable w/o a patch :)
	use firefox && G2CONF="${G2CONF} --with-gtkmozembed=firefox"
	if ! use firefox; then
		use mozilla && G2CONF="${G2CONF} --with-gtkmozembed=mozilla"
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
