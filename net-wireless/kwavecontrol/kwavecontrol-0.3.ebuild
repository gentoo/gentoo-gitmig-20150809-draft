# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kwavecontrol/kwavecontrol-0.3.ebuild,v 1.1 2003/02/09 13:47:23 hannes Exp $

newdepend "net-wireless/wireless-tools"
inherit kde-base
need-kde 3
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://kwc.progeln.de/"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
DESCRIPTION="KWaveControl is a little tool for WaveLAN wireless cards based on the wireless extensions."
