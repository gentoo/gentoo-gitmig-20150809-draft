# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/projectcenter/projectcenter-0.3.5.ebuild,v 1.2 2004/07/23 14:59:37 fafhrd Exp $

inherit gnustep-old

S=${WORKDIR}/ProjectCenter

DESCRIPTION="GNUstep project developer"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dev-apps/ProjectCenter-${PV}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=gnustep-base/gnustep-gui-0.8.5"

src_unpack() {
	unpack ProjectCenter-${PV}.tar.gz
	cd ${S}
}
