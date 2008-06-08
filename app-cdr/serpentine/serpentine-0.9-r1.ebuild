# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/serpentine/serpentine-0.9-r1.ebuild,v 1.1 2008/06/08 08:31:42 drac Exp $

inherit eutils gnome2 mono multilib python

DESCRIPTION="Serpentine is an application for writing CD-Audio discs. It aims
for simplicity, usability and compability."
HOMEPAGE="http://irrepupavel.com/projects/serpentine/"
SRC_URI="mirror://berlios/serpentine/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="muine"

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/pygtk-2.6
	>=dev-python/gnome-python-desktop-2.14.0
	>=dev-python/gst-python-0.10
	gnome-base/gconf
	>=media-plugins/gst-plugins-gnomevfs-0.10
	muine? ( media-sound/muine )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable muine)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo serpentine/gtkutil.py >> po/POTFILES.skip
	echo serpentine/plugins/plugsuspend.py >> po/POTFILES.skip
	epatch "${FILESDIR}"/${P}-drop_pyxml.patch \
		"${FILESDIR}"/${P}-python24_compat.patch
	rm -f py-compile || die "removing failed."
	ln -s $(type -P true) py-compile || die "symlinking failed."
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup
}
