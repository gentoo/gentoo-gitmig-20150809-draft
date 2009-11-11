# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/komport/komport-0.5.9-r1.ebuild,v 1.2 2009/11/11 12:46:24 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="Komport - Serial port communications and vt102 terminal emulator for KDE"
HOMEPAGE="http://komport.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

need-kde 3.5

PATCHES=( "${FILESDIR}/komport-0.5.9-gcc43.diff"
	"${FILESDIR}/komport-0.5.9-desktop-file.diff" )
