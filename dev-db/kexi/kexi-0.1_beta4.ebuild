# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kexi/kexi-0.1_beta4.ebuild,v 1.4 2005/06/03 14:51:55 greg_g Exp $

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

DEPEND="!>=app-office/koffice-1.4_rc
	!app-office/kexi"

need-kde 3.2
