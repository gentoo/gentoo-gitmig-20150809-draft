# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyosd/pyosd-0.2.9.ebuild,v 1.2 2004/04/16 14:58:36 dholm Exp $

inherit distutils

DESCRIPTION="PyOSD is a python module for displaying text on your X display, much like the 'On Screen Displays' used on TVs and some monitors."
HOMEPAGE="http://repose.cx/pyosd/"
SRC_URI="http://repose.cx/pyosd/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/python
	>=x11-libs/xosd-2.2.4"

