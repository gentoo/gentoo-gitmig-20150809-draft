# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/umtsmon/umtsmon-0.5.ebuild,v 1.1 2007/03/31 09:05:35 mrness Exp $

inherit qt3

DESCRIPTION="UMTSmon is a tool to control and monitor a wireless mobile network card (GPRS, EDGE, WCDMA, UMTS, EV-DO, HSDPA)"
HOMEPAGE="http://umtsmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/umtsmon/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)"
RDEPEND="${DEPEND}
	net-dialup/ppp
	sys-apps/pcmciautils"

src_install() {
	dobin umtsmon
}
