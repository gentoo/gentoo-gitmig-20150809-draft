# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libtpm/libtpm-2.0.ebuild,v 1.1 2005/02/03 11:12:02 dragonheart Exp $

DESCRIPTION="Driver for TPM chips"

HOMEPAGE="http://www.research.ibm.com/gsal/tcpa/"
SRC_URI="http://www.research.ibm.com/gsal/tcpa/TPM-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

RDEPEND="dev-libs/openssl"

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
