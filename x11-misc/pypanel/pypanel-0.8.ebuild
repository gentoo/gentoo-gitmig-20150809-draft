# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pypanel/pypanel-0.8.ebuild,v 1.1 2003/11/09 22:48:09 karltk Exp $

DESCRIPTION="PyPanel is a lightweight panel/taskbar for X11 window managers."
HOMEPAGE="http://pypanel.sourceforge.net"
SRC_URI="mirror://sourceforge/pypanel/PyPanel-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=x11-base/xfree-4.3.0-r2
	>=dev-lang/python-2.2.3-r1
	>=dev-python/python-xlib-0.12"
S="${WORKDIR}/PyPanel-${PV}"

inherit distutils

src_compile() {
	distutils_src_install
}

src_install() {
	distutils_src_install
}
