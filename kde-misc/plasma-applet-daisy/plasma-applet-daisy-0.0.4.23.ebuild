# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/plasma-applet-daisy/plasma-applet-daisy-0.0.4.23.ebuild,v 1.1 2010/07/07 09:43:53 spatz Exp $

EAPI="2"

inherit kde4-base

DESCRIPTION="A simple application launcher for KDE 4's plasma desktop"
HOMEPAGE="http://cdlszm.org/"
SRC_URI="http://cdlszm.org/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
