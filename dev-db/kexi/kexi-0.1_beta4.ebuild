# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kexi/kexi-0.1_beta4.ebuild,v 1.1 2004/07/16 15:59:56 carlo Exp $

inherit kde

MY_P=${P/_beta/beta}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Integrated environment for managing data."
HOMEPAGE="http://kexi-project.org/"
SRC_URI="mirror://kde/unstable/apps/KDE3.x/office/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

need-kde 3.2