# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/ksimus-floatingpoint/ksimus-floatingpoint-0.3.6.ebuild,v 1.1 2004/12/28 15:29:51 ribosome Exp $

inherit kde

DESCRIPTION="The package Floating Point contains some floating point related components for KSimus."
HOMEPAGE="http://ksimus.berlios.de/"
KEYWORDS="x86"
SRC_URI="http://ksimus.berlios.de/download/ksimus-floatingpoint-3-${PV}.tar.gz"

LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND="sci-mathematics/ksimus"

need-kde 3
