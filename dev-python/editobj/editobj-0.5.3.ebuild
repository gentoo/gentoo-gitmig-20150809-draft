# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/editobj/editobj-0.5.3.ebuild,v 1.2 2004/04/01 00:27:47 kloeri Exp $

inherit distutils

MY_P=${P/editobj/EditObj}
IUSE=""
DESCRIPTION="EditObj can create a dialog box to edit ANY Python object. It also includes a Tk tree widget, an event and a multiple undo-redo frameworks."
SRC_URI="http://oomadness.tuxfamily.org/downloads/${MY_P}.tar.gz
	http://www.nectroom.homelinux.net/pkg/${MY_P}.tar.gz
	http://nectroom.homelinux.net/pkg/${MY_P}.tar.gz"
HOMEPAGE="http://oomadness.tuxfamily.org/en/editobj/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/x11
	virtual/opengl
	>=dev-lang/python-2.2.2
	>=dev-lang/tk-8.3"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	distutils_python_tkinter
}
