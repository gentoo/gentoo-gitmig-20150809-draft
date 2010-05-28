# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pypanel/pypanel-2.4-r1.ebuild,v 1.1 2010/05/28 20:54:49 hwoarang Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit distutils eutils

MY_PN=${PN/pyp/PyP}
MY_P=${MY_PN}-${PV}

DESCRIPTION="A lightweight panel/taskbar for X11 window managers"
HOMEPAGE="http://pypanel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="x11-libs/libXft
	dev-lang/python
	dev-python/python-xlib
	sys-apps/sed
	media-libs/imlib2[X]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
