# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/thunarx-python/thunarx-python-0.2.0.ebuild,v 1.1 2010/10/26 19:59:48 xmw Exp $

EAPI=2

inherit python xfconf

DESCRIPTION="Python bindings for the Thunar file manager"
HOMEPAGE="http://code.google.com/p/rabbitvcs"
SRC_URI="http://rabbitvcs.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	dev-python/pygobject:2
	dev-python/pygtk:2
	xfce-base/thunar"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	DOCS="AUTHORS ChangeLog NEWS"
}

src_install() {
	xfconf_src_install \
		docsdir=/usr/share/doc/${PF} \
		examplesdir=/usr/share/doc/${PF}/examples
}
