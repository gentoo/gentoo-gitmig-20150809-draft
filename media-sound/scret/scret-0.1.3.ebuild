# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/scret/scret-0.1.3.ebuild,v 1.4 2004/06/29 10:45:54 carlo Exp $

inherit kde

S=${WORKDIR}/ScoreReadingTrainer-${PV}

DESCRIPTION="A musical score reading trainer"
HOMEPAGE="http://scret.sourceforge.net"
SRC_URI="mirror://sourceforge/scret/ScoreReadingTrainer-${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

need-kde 3.1


