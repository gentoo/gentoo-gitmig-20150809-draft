# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-1.2.5_beta20020714-r1.ebuild,v 1.2 2002/08/14 15:45:39 murphy Exp $

inherit commonbox

S=${WORKDIR}/${PN}-14072002
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://openbox.sunsite.dk"

SLOT="2"
LICENSE="BSD"
KEYWORDS="x86 sparc sparc64"

MYBIN="${PN}-dev"
mydoc="CHANGE* TODO LICENSE BUGS CodingStyle data/README*"
myconf="--program-suffix=-dev --enable-xft"

src_compile() {

	./bootstrap
	commonbox_src_compile
}
