# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/scret/scret-0.1.3.ebuild,v 1.3 2004/06/25 00:21:22 agriffis Exp $

inherit kde-base
need-kde 3.1

DESCRIPTION="A musical score reading trainer"
SRC_URI="mirror://sourceforge/scret/ScoreReadingTrainer-${PV}.tar.bz2"
HOMEPAGE="http://scret.sourceforge.net"

S=${WORKDIR}/ScoreReadingTrainer-${PV}

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE=""
SLOT="0"

DEPEND=""

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO || die
}

