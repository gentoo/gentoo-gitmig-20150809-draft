# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbattery/wmbattery-1.2.1-r1.ebuild,v 1.8 2004/03/26 23:10:07 aliz Exp $

IUSE=""
S=${WORKDIR}/wmbattery
DESCRIPTION="A dockable app to report APM battery stats."
SRC_URI="http://kitenet.net/programs/code/wmbattery/wmbattery.tar.gz"
HOMEPAGE="http://kitenet.net/programs/wmbattery"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"

src_install () {
	dobin wmbattery
	doman wmbattery.1x
	dodoc README COPYING TODO

	#install the icons.
	insinto /usr/share/pixmaps/wmbattery
	doins *.xpm
}
