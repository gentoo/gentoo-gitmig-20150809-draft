# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/komport/komport-0.5.9.ebuild,v 1.9 2007/02/05 11:01:00 flameeyes Exp $

inherit kde

DESCRIPTION="Komport - Serial port communications and vt102 terminal emulator for KDE"
HOMEPAGE="http://komport.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

need-kde 3
