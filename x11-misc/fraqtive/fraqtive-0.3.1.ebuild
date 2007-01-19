# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fraqtive/fraqtive-0.3.1.ebuild,v 1.1 2007/01/19 15:22:49 drizzt Exp $

inherit kde

DESCRIPTION="Fraqtive is a KDE-based program for interactively drawing Mandelbrot and Julia fractals"
HOMEPAGE="http://fraqtive.mimec.org/"
SRC_URI="http://fraqtive.mimec.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

need-kde 3.2
