# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kmasqdialer/kmasqdialer-2.05.ebuild,v 1.5 2004/06/28 20:26:03 carlo Exp $

inherit kde

DESCRIPTION="KMasqdialer - A KDE Client for MasqDialer"
HOMEPAGE="http://www.stephan.co.uk/kmasqdialer"
# old and non-working: SRC_URI="http://www.stephan.co.uk/kmasqdialer/${P}.tar.gz"
SRC_URI="ftp://ftp.kde.com/Networking_Internet/PPP_Chap_SLIP/KMasqDialer_2/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

need-kde 3
