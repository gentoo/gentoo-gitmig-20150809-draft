# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kmasqdialer/kmasqdialer-2.05.ebuild,v 1.2 2003/09/08 07:10:17 msterret Exp $

IUSE=""

inherit kde-base

DESCRIPTION="KMasqdialer - A KDE Client for MasqDialer"
SRC_URI=" http://www.stephan.co.uk/kmasqdialer/${P}.tar.gz"
HOMEPAGE="http://www.stephan.co.uk/kmasqdialer/download.html"

LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3
