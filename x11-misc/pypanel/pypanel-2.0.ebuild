# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pypanel/pypanel-2.0.ebuild,v 1.1 2004/11/06 02:08:04 karltk Exp $

inherit distutils

DESCRIPTION="PyPanel is a lightweight panel/taskbar for X11 window managers."
HOMEPAGE="http://pypanel.sourceforge.net"
SRC_URI="mirror://sourceforge/pypanel/PyPanel-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""
DEPEND="virtual/x11
	>=dev-lang/python-2.2.3-r1
	>=dev-python/python-xlib-0.12
	>=sys-apps/sed-4
	>=media-libs/imlib2-1.1"
S="${WORKDIR}/PyPanel-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_install() {
	distutils_src_install
}

pkg_postinst() {
	ewarn "If you previously ran 1.3, please remove ~/.pypanelrc before starting ${PV}!"
	ewarn "Otherwise, you will most likely get a Python NameError about ICON."
}
