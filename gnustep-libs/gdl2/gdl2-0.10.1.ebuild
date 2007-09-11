# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/gdl2/gdl2-0.10.1.ebuild,v 1.1 2007/09/11 18:35:42 voyageur Exp $

inherit gnustep-2

MY_P="gnustep-dl2-${PV}"
DESCRIPTION="GNUstep Database Library 2 (GDL2) for mapping Obj-C to RDBMSes"
HOMEPAGE="http://www.gnustep.org/"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"

S=${WORKDIR}/${MY_P}

DEPEND="!gnustep-apps/sope
	dev-db/postgresql"
RDEPEND="${DEPEND}"
