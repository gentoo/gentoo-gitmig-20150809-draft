# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/caps-plugins/caps-plugins-0.1.10.ebuild,v 1.5 2004/07/06 18:36:25 slarti Exp $

inherit eutils

IUSE=""
#
MY_P=caps-${PV}

DESCRIPTION="caps ladspa plugins"
HOMEPAGE="http://quitte.de/dsp/caps.html"
SRC_URI="http://quitte.de/dsp/caps_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/caps-plugins-0.1.10-fpic.patch || die
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc AUTHORS COPYING README
	dolib.so *.so
}
