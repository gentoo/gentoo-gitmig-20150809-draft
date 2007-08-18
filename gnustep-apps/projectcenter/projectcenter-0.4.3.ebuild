# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/projectcenter/projectcenter-0.4.3.ebuild,v 1.3 2007/08/18 15:23:21 angelos Exp $

inherit gnustep

S=${WORKDIR}/${P/projectc/ProjectC}

DESCRIPTION="An IDE for GNUstep."
HOMEPAGE="http://www.gnustep.org/experience/ProjectCenter.html"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dev-apps/${P/projectc/ProjectC}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}
	>=sys-devel/gdb-6.0"

egnustep_install_domain "System"

src_unpack() {
	unpack ${A}
	cd ${S}
	egnustep_env
	if [ -z "${GNUSTEP_FLATTENED}" ]; then
		epatch ${FILESDIR}/pc-non-flattened.patch
	fi
}
