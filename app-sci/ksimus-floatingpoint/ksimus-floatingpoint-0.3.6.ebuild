# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksimus-floatingpoint/ksimus-floatingpoint-0.3.6.ebuild,v 1.3 2004/03/26 12:21:06 phosphan Exp $

inherit kde-base

DESCRIPTION="The package Floating Point contains some floating point related components for KSimus."
HOMEPAGE="http://ksimus.berlios.de/"
KEYWORDS="x86"
SRC_URI="http://ksimus.berlios.de/download/ksimus-floatingpoint-3-${PV}.tar.gz"

LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND="app-sci/ksimus"

need-kde 3
