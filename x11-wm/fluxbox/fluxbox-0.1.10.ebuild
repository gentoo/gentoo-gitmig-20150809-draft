# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.1.10.ebuild,v 1.3 2002/08/04 22:08:42 spider Exp $

inherit commonbox flag-o-matic


S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on Blackbox and pwm -- has tabs."
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://fluxbox.sf.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

mydoc="ChangeLog COPYING NEWS"
myconf="--enable-xinerama"
filter-flags -fno-exceptions
src_compile() {

	commonbox_src_compile

	cd data
	make init
}


src_install() {

	commonbox_src_install
	cd data
	insinto /usr/share/commonbox
	doins init
}
