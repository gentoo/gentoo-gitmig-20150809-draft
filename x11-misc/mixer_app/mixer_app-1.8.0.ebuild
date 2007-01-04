# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mixer_app/mixer_app-1.8.0.ebuild,v 1.11 2007/01/04 23:19:29 beandog Exp $

#need to do some name mangling
#so that ebuild name adheres to "standart"
Name=Mixer.app
S=${WORKDIR}/${Name}-${PV}

DESCRIPTION="mixer utility that has three volume controllers that can be configured to handle any sound source"
HOMEPAGE="http://www.fukt.bth.se/~per/mixer/"
SRC_URI="http://www.fukt.bth.se/~per/mixer/${Name}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_compile() {
	emake || die
}

src_install() {
	#make DESTDIR=${D} install || die
	dobin Mixer.app
	dodoc README ChangeLog
}
