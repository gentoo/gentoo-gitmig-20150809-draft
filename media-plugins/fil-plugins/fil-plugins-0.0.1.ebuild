# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/fil-plugins/fil-plugins-0.0.1.ebuild,v 1.4 2004/09/01 17:35:46 eradicator Exp $

#
MY_P=${P/fil/FIL}

DESCRIPTION="FIL-plugins ladspa plugin package. Filters by Fons Adriaensen"
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio/"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake || die
}

src_install() {
	dodoc AUTHORS COPYING README
	insinto /usr/lib/ladspa
	insopts -m0755
	doins *.so
}
