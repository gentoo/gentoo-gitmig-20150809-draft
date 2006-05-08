# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/fil-plugins/fil-plugins-0.1.0.ebuild,v 1.1 2006/05/08 23:21:33 fvdpol Exp $

#
MY_P=${P/fil/FIL}

DESCRIPTION="FIL-plugins ladspa plugin package. Filters by Fons Adriaensen"
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio/"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
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
