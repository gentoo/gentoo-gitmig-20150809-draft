# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Michael Gayeski <gayeski@cae.wisc.edu>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmbattery/wmbattery-1.2.1-r1.ebuild,v 1.3 2002/07/08 21:31:07 aliz Exp $

S=${WORKDIR}/wmbattery
DESCRIPTION="A dockable app to report APM battery stats."
SRC_URI="http://kitenet.net/programs/code/wmbattery/wmbattery.tar.gz"
HOMEPAGE="http://kitenet.net/programs/wmbattery"
DEPEND="x11-base/xfree virtual/glibc"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

src_install () {
	dobin wmbattery
	doman wmbattery.1x
	dodoc README COPYING TODO
	
	#install the icons.
	insinto /usr/share/icons/wmbattery
	doins *.xpm
}
