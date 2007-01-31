# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/ktechlab/ktechlab-0.3.ebuild,v 1.2 2007/01/31 18:50:06 calchan Exp $

inherit kde

DESCRIPTION="KTechlab is a development and simulation environment for microcontrollers and electronic circuits"
HOMEPAGE="http://ktechlab.org/"
SRC_URI="http://ktechlab.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

IUSE=""
SLOT="0"

DEPEND=">=dev-embedded/gpsim-0.21.11"

need-kde 3.2

UNSERMAKE=""

PATCHES="${FILESDIR}/${P}-gcc-4.1.patch"
