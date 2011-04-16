# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pypanel/pypanel-2.4.ebuild,v 1.12 2011/04/16 18:48:24 armin76 Exp $

EAPI="3"
inherit distutils

MY_PN=${PN/pyp/PyP}
MY_P=${MY_PN}-${PV}

DESCRIPTION="A lightweight panel/taskbar for X11 window managers"
HOMEPAGE="http://pypanel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

RDEPEND="x11-libs/libXft
	dev-lang/python
	dev-python/python-xlib
	sys-apps/sed
	media-libs/imlib2[X]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}
