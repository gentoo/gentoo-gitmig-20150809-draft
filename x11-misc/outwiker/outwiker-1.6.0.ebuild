# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/outwiker/outwiker-1.6.0.ebuild,v 1.1 2012/07/18 06:46:43 yngwin Exp $

EAPI=4
PYTHON_DEPEND="2:2.7"
inherit python

DESCRIPTION="The tree notes organizer"
HOMEPAGE="http://jenyay.net/Outwiker/English"
SRC_URI="http://jenyay.net/uploads/Soft/Outwiker/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/libgnomeprint-python
	dev-python/pywebkitgtk
	dev-python/wxpython"
DEPEND="${RDEPEND}"

src_compile() { :; }

pkg_postinst() {
	python_mod_optimize "${D}/usr/share/${PN}"
}
