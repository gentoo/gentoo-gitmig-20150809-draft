# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-biggles/python-biggles-1.6.3.ebuild,v 1.6 2003/09/02 22:32:41 liquidx Exp $

inherit distutils

DESCRIPTION="A Python module for creating publication-quality 2D scientific plots."
SRC_URI="mirror://sourceforge/biggles/${P}.tar.gz"
HOMEPAGE="http://biggles.sourceforge.net"

DEPEND="~media-libs/plotutils-2.4.1
        dev-python/numeric"
		
IUSE=""		
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

mydoc="examples/*"
