# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-0.99.3-r1.ebuild,v 1.2 2002/08/14 15:45:39 murphy Exp $

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="ftp://sunsite.dk/projects/openbox/${P}.tar.gz"
HOMEPAGE="http://openbox.sunsite.dk"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc sparc64"

myconf="--program-suffix=-old"
MYBIN="${PN}-old"
mydoc="ChangeLog TODO LICENSE BUGS"
