# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pypanel/pypanel-1.3.ebuild,v 1.1 2004/07/20 23:46:40 karltk Exp $

inherit distutils

DESCRIPTION="PyPanel is a lightweight panel/taskbar for X11 window managers."
HOMEPAGE="http://pypanel.sourceforge.net"
SRC_URI="mirror://sourceforge/pypanel/PyPanel-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/x11
	>=dev-lang/python-2.2.3-r1
	>=dev-python/python-xlib-0.12
	>=sys-apps/sed-4"
S="${WORKDIR}/PyPanel-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Removing offensive material
	sed -i -e "s/%D %I:%M %p/%Y-%m-%d %H:%M/" pypanelrc
}

src_install() {
	distutils_src_install
}

pkg_postinst() {
	ewarn "If you previously ran 0.8, please remove ~/.pypanelrc before starting ${PV}!"
}
