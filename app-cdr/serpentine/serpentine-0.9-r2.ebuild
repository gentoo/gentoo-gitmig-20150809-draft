# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/serpentine/serpentine-0.9-r2.ebuild,v 1.7 2011/04/16 19:45:06 arfrever Exp $

EAPI="3"
GCONF_DEBUG=no
PYTHON_DEPEND="2"

inherit autotools eutils gnome2 mono python

DESCRIPTION="An application for writing CD-Audio discs. It aims for simplicity, usability and compability."
HOMEPAGE="http://irrepupavel.com/projects/serpentine/"
SRC_URI="mirror://berlios/serpentine/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="muine"

RDEPEND=">=dev-python/pygtk-2.6:2
	>=dev-python/gst-python-0.10
	dev-python/gconf-python
	dev-python/gnome-vfs-python
	dev-python/pygobject:2
	>=media-plugins/gst-plugins-gnomevfs-0.10
	muine? ( media-sound/muine )
	dev-python/pyxml"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	G2CONF="${G2CONF} $(use_enable muine)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	echo serpentine/gtkutil.py >> po/POTFILES.skip
	echo serpentine/plugins/plugsuspend.py >> po/POTFILES.skip

	epatch "${FILESDIR}"/${P}-drop_pyxml.patch \
		"${FILESDIR}"/${P}-python24_compat.patch

	rm -f py-compile || die "rm failed."
	ln -s $(type -P true) py-compile || die "ln failed."

	intltoolize --force --copy --automake || die "intltoolize failed."
	eautoreconf

	python_convert_shebangs -r $(python_get_version) .
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize ${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup ${PN}
}
