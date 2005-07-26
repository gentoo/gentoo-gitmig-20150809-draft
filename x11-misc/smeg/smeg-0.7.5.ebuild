# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/smeg/smeg-0.7.5.ebuild,v 1.4 2005/07/26 14:53:59 dholm Exp $

DESCRIPTION="Simple Menu Editor for Gnome, written in Python"
HOMEPAGE="http://www.realistanew.com/projects/smeg/"
SRC_URI="http://dev.realistanew.com/smeg/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnome"

DEPEND=">=dev-lang/python-2.4
	>=dev-python/pyxdg-0.14
	gnome? ( >=gnome-base/gnome-menus-2.10.1 )
	>=dev-python/pygtk-2.0"

src_compile() {
	einfo "No compilation necessary"
}

src_install() {
	python setup.py install --prefix=${D}/usr || die
	insinto /usr/share/applications
	doins smeg-kde.desktop
	doins smeg.desktop
}
