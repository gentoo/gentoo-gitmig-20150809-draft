# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>

S=${WORKDIR}/${P}
DESCRIPTION="blackbox program execution dialog box"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/contrib/bbrun-1.1.tar.gz"
HOMEPAGE="http://bbtools.thelinuxcommunity.org/contrib.phtml"

DEPEND=">=x11-wm/blackbox-0.61 >=x11-libs/gtk+-1.2.10"

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

	cd ${S}/bbrun
    try emake

}

src_install () {


	dodoc README COPYING
	dobin bbrun/bbrun
}

