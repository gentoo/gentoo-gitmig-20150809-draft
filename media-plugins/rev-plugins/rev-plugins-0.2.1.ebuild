# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/rev-plugins/rev-plugins-0.2.1.ebuild,v 1.7 2004/09/01 17:37:39 eradicator Exp $
#
MY_P=${P/rev/REV}

DESCRIPTION="REV LADSPA plugins package. A stereo reverb plugin based on the well-known greverb"
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio/"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

IUSE=""

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_compile() {
	make || die
}

src_install() {
	dodoc AUTHORS COPYING README ${S}/ams/*
	insinto /usr/lib/ladspa
	insopts -m0755
	doins *.so
}
