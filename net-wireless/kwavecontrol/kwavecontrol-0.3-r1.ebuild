# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kwavecontrol/kwavecontrol-0.3-r1.ebuild,v 1.1 2004/04/30 21:41:51 centic Exp $

inherit kde
need-kde 3
newdepend "net-wireless/wireless-tools"

PATCHES="${FILESDIR}/${P}-gentoo.diff ${FILESDIR}/${P}-installdirs.diff"

DESCRIPTION="KWaveControl is a little tool for WaveLAN wireless cards based on the wireless extensions."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://kwavecontrol.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE=""
SLOT="0"

