# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kwavecontrol/kwavecontrol-0.3.ebuild,v 1.6 2004/03/14 17:30:20 mr_bones_ Exp $

inherit kde
need-kde 3
newdepend "net-wireless/wireless-tools"
PATCHES="${FILESDIR}/${P}-gentoo.diff"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://kwc.progeln.de/"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""
DESCRIPTION="KWaveControl is a little tool for WaveLAN wireless cards based on the wireless extensions."
