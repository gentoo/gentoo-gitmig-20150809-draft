# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-synaesthesia/xmms-synaesthesia-0.0.3_rc3.ebuild,v 1.1 2003/06/22 03:22:46 jje Exp $

MY_P=${PN#*-}-${PN%-*}-${PV/_rc/-rc}

S=${WORKDIR}/${MY_P}
SRC_URI="http://staff.xmms.org/zinx/xmms/${MY_P}.tar.gz"
HOMEPAGE="http://staff.xmms.org/zinx/xmms/"
DESCRIPTION="Synaesthesia effect in a XMMS version."

DEPEND="media-sound/xmms"
RDEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
}


src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install
}


