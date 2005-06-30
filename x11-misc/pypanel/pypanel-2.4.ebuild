# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pypanel/pypanel-2.4.ebuild,v 1.1 2005/06/30 04:37:16 smithj Exp $

inherit distutils eutils

MY_PN="${PN/pyp/PyP}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PyPanel is a lightweight panel/taskbar for X11 window managers."
HOMEPAGE="http://pypanel.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"

IUSE=""
DEPEND="virtual/x11
	>=dev-lang/python-2.2.3-r1
	>=dev-python/python-xlib-0.12
	>=sys-apps/sed-4
	>=media-libs/imlib2-1.1"

S="${WORKDIR}/${MY_P}"

