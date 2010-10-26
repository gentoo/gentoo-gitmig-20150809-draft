# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/thunarx-python/thunarx-python-0.2.0.ebuild,v 1.3 2010/10/26 20:08:54 ssuominen Exp $

EAPI=2
PYTHON_DEPEND=2
inherit python xfconf

DESCRIPTION="Python bindings for the Thunar file manager"
HOMEPAGE="http://code.google.com/p/rabbitvcs"
SRC_URI="http://rabbitvcs.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	>=dev-python/gnome-python-base-2.12
	>=dev-python/pygobject-2.16:2
	dev-python/pygtk:2
	xfce-base/thunar"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(xfconf_use_debug)"
	DOCS="AUTHORS ChangeLog NEWS README"

	python_set_active_version 2
}

src_install() {
	xfconf_src_install \
		docsdir=/usr/share/doc/${PF} \
		examplesdir=/usr/share/doc/${PF}/examples
}
