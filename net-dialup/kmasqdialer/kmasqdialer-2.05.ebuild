# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kmasqdialer/kmasqdialer-2.05.ebuild,v 1.4 2004/06/24 22:28:21 agriffis Exp $

IUSE=""

inherit kde-base

DESCRIPTION="KMasqdialer - A KDE Client for MasqDialer"
# old and non-working: SRC_URI="http://www.stephan.co.uk/kmasqdialer/${P}.tar.gz"
SRC_URI="ftp://ftp.kde.com/Networking_Internet/PPP_Chap_SLIP/KMasqDialer_2/${P}.tar.gz"
HOMEPAGE="http://www.stephan.co.uk/kmasqdialer/download.html"

LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3
