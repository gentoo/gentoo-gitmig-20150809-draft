# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

DESCRIPTION="Linux Audio Developer's Configuration and Connection API (LADCCA)"
HOMEPAGE="http://pkl.net/~node/ladcca.html"
SRC_URI="http://pkl.net/~node/software/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="media-libs/alsa-lib \
	virtual/jack \
	>=x11-libs/gtk+-2.0" 

S=${WORKDIR}/${P}

src_compile() {
        econf || die
	emake || die
}

src_install() {
	einstall
}
