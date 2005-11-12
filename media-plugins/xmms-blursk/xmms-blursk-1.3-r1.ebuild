# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-blursk/xmms-blursk-1.3-r1.ebuild,v 1.1 2005/11/12 17:45:58 metalgod Exp $

IUSE=""

inherit eutils gnuconfig

MY_P=Blursk-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Yet another psychedelic visualization plug-in for XMMS"
HOMEPAGE="http://www.cs.pdx.edu/~kirkenda/blursk/"
SRC_URI="http://www.cs.pdx.edu/~kirkenda/blursk/${MY_P}.tar.gz"

DEPEND="media-sound/xmms"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-segfault.patch
	gnuconfig_update
}

src_install () {
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS ChangeLog README NEWS
}
