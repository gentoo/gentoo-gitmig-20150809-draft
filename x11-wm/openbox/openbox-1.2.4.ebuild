# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-1.2.4.ebuild,v 1.1 2002/07/15 04:13:13 seemant Exp $

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="ftp://sunsite.dk/projects/openbox/${P}.tar.gz"
HOMEPAGE="http://openbox.sunsite.dk"

SLOT="1"
LICENSE="BSD"
KEYWORDS="x86"

myconf="--with-x \
	--enable-shape \
	--enable-slit \
	--enable-interlace \
	--enable-clobber"


mydoc="CHANGE* LICENSE BUGS CodingStyle data/README*"
