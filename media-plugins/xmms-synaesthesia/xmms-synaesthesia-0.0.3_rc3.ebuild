# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-synaesthesia/xmms-synaesthesia-0.0.3_rc3.ebuild,v 1.4 2004/06/24 23:46:29 agriffis Exp $

IUSE=""

MY_P=${PN#*-}-${PN%-*}-${PV/_rc/-rc}

S=${WORKDIR}/${MY_P}
SRC_URI="http://staff.xmms.org/zinx/xmms/${MY_P}.tar.gz"
HOMEPAGE="http://staff.xmms.org/zinx/xmms/"
DESCRIPTION="Synaesthesia effect in a XMMS version."

DEPEND="media-sound/xmms"
RDEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

src_install() {
	make DESTDIR=${D} install
}


