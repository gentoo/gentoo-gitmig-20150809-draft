# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libksba/libksba-0.4.7.ebuild,v 1.8 2005/02/06 17:29:40 corsair Exp $

DESCRIPTION="KSBA makes X.509 certificates and CMS easily accessible to applications"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/aegypten/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install(){
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README README-alpha THANKS TODO VERSION
}
