# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/karchiver/karchiver-3.4.2-r4.ebuild,v 1.1 2007/03/20 23:22:57 genstef Exp $

inherit kde

MY_PF=${PF/-r/.b}
S=$WORKDIR/$MY_PF

DESCRIPTION="Utility to ease working with compressed files such as tar.gz/tar.bz2"
HOMEPAGE="http://perso.wanadoo.fr/coquelle/karchiver/"
SRC_URI="http://perso.wanadoo.fr/coquelle/karchiver/${MY_PF}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
IUSE=""

need-kde 3.4
