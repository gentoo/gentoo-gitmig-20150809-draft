# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mixer_app/mixer_app-1.8.0.ebuild,v 1.3 2004/04/11 15:18:33 pyrania Exp $

#need to do some name mangling
#so that ebuild name adheres to "standart"
Name=Mixer.app
S=${WORKDIR}/${Name}-${PV}

DESCRIPTION="mixer utility that has three volume controllers that can be configured to handle any sound source"
HOMEPAGE="http://www.fukt.bth.se/~per/mixer/"
SRC_URI="http://www.fukt.bth.se/~per/mixer/${Name}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="virtual/glibc x11-base/xfree "

src_compile() {
	emake || die
}

src_install() {
	#make DESTDIR=${D} install || die
	dobin Mixer.app
	dodoc COPYING README ChangeLog
}
