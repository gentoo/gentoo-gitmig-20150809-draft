# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-synaesthesia/xmms-synaesthesia-0.0.3_rc3.ebuild,v 1.7 2004/07/15 19:45:54 slarti Exp $

IUSE=""

inherit gnuconfig eutils

MY_P=${PN#*-}-${PN%-*}-${PV/_rc/-rc}

S=${WORKDIR}/${MY_P}
SRC_URI="http://staff.xmms.org/zinx/xmms/${MY_P}.tar.gz"
HOMEPAGE="http://staff.xmms.org/zinx/xmms/"
DESCRIPTION="Synaesthesia effect in a XMMS version."

DEPEND="media-sound/xmms"
RDEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~amd64"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34.patch
	use amd64 && epatch ${FILESDIR}/${P}-amd64.patch
	gnuconfig_update
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
