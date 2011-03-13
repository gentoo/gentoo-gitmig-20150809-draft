# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scapy/scapy-2.2.0.ebuild,v 1.1 2011/03/13 15:32:01 ikelos Exp $

PYTHON_DEPEND="2:2.6"

inherit distutils

DESCRIPTION="A Python interactive packet manipulation program for mastering the network"
HOMEPAGE="http://www.secdev.org/projects/scapy/"
SRC_URI="http://www.secdev.org/projects/scapy/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnuplot pyx crypt graphviz imagemagick visual tcpreplay"

DEPEND="virtual/python"
RDEPEND="net-analyzer/tcpdump
	gnuplot? ( dev-python/gnuplot-py )
	pyx? ( dev-python/pyx )
	crypt? ( dev-python/pycrypto )
	graphviz? ( media-gfx/graphviz )
	imagemagick? ( media-gfx/imagemagick )
	visual? ( dev-python/visual )
	tcpreplay? ( net-analyzer/tcpreplay )"
