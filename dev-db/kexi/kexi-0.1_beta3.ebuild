# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kexi/kexi-0.1_beta3.ebuild,v 1.4 2005/01/01 17:34:18 eradicator Exp $
inherit kde
need-kde 3.2

MY_P=${P/_beta/beta}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Integrated environment for managing data."
SRC_URI="mirror://kde/unstable/apps/KDE3.x/office/${MY_P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://kexi-project.org/"
LICENSE="GPL-2"
IUSE=""

SLOT="0"
KEYWORDS="~x86 ~ppc"

