# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/projectcenter/projectcenter-0.3.5.ebuild,v 1.5 2004/07/22 21:44:31 fafhrd Exp $

inherit gnustep-old

S=${WORKDIR}/ProjectCenter

DESCRIPTION="GNUstep project developer"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dev-apps/ProjectCenter-${PV}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-util/gnustep-gui-0.8.5"

src_unpack() {
	unpack ProjectCenter-${PV}.tar.gz
	cd ${S}
}
