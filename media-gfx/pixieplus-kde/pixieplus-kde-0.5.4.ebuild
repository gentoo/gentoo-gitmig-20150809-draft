# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixieplus-kde/pixieplus-kde-0.5.4.ebuild,v 1.3 2003/05/05 19:15:18 pauldv Exp $

inherit kde-base 

need-kde 3.1

DESCRIPTION="Mosfet's KDE image/photo viewer, editor, and manager"

SRC_URI="http://www.mosfet.org/pixie/pixieplus-${PV}.tar.gz"

HOMEPAGE="http://www.mosfet.org/pixie"

# eeek! - danarmak
LICENSE="QPL-1.0 LGPL-2 BSD"
KEYWORDS="~x86 ~ppc"

DEPEND=">=media-gfx/imagemagick-5.5"

newdepend ">=kde-base/kdebase-3.1
	    media-libs/libungif"

S=${WORKDIR}/pixieplus-${PV}
