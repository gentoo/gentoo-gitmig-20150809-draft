# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kexi/kexi-0.1_beta4.ebuild,v 1.3 2005/01/01 17:34:18 eradicator Exp $

inherit kde

MY_P=${P/_beta/beta}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Integrated environment for managing data."
HOMEPAGE="http://kexi-project.org/"
SRC_URI="mirror://kde/unstable/apps/KDE3.x/office/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

need-kde 3.2
