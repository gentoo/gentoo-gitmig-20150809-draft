# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.6.2.ebuild,v 1.1 2004/06/19 12:47:44 carlo Exp $

inherit kde

MY_P=${P/_rc?/RC}
S=${WORKDIR}/${PN}

DESCRIPTION="A KDE frontend for gPhoto 2"
HOMEPAGE="http://digikam.sourceforge.net/"
#SRC_URI="http://digikam.free.fr/Tarballs/${MY_P}.tar.bz2"
#rc's are not via sf available
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

# kdesdk dependency, because of xml2pot usage, this is a
# known upstream bug, that should be fixed in the final
# * still in 0.6.2
DEPEND="kde-base/kdesdk
	>=media-gfx/gphoto2-2.0-r1"

need-kde 3