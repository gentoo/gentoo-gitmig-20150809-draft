# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kwavecontrol/kwavecontrol-0.3-r1.ebuild,v 1.3 2004/07/21 14:19:39 carlo Exp $

inherit kde

PATCHES="${FILESDIR}/${P}-gentoo.diff ${FILESDIR}/${P}-installdirs.diff"

DESCRIPTION="KWaveControl is a little tool for WaveLAN wireless cards based on the wireless extensions."
HOMEPAGE="http://kwavecontrol.sourceforge.net/"
SRC_URI="mirror://sourceforge/kwavecontrol/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

IUSE=""
SLOT="0"

RDEPEND="net-wireless/wireless-tools"
need-kde 3