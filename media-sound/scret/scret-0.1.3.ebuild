# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/scret/scret-0.1.3.ebuild,v 1.5 2004/07/20 06:12:59 eradicator Exp $

inherit kde

S=${WORKDIR}/ScoreReadingTrainer-${PV}

DESCRIPTION="A musical score reading trainer"
HOMEPAGE="http://scret.sourceforge.net"
SRC_URI="mirror://sourceforge/scret/ScoreReadingTrainer-${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

need-kde 3.1


