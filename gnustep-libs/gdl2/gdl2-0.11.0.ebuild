# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/gdl2/gdl2-0.11.0.ebuild,v 1.1 2007/12/08 18:01:38 voyageur Exp $

inherit gnustep-2

MY_P="gnustep-dl2-${PV}"
DESCRIPTION="GNUstep Database Library 2 (GDL2) for mapping Obj-C to RDBMSes"
HOMEPAGE="http://www.gnustep.org/"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="postgres sqlite"

S=${WORKDIR}/${MY_P}

DEPEND="!gnustep-apps/sope
	postgres? ( dev-db/libpq )
	sqlite? ( dev-db/sqlite )"
RDEPEND="${DEPEND}"
