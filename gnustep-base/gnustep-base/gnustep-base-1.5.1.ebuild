# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-base/gnustep-base-1.5.1.ebuild,v 1.1 2004/07/23 13:54:02 fafhrd Exp $

IUSE=""
DESCRIPTION="GNUstep base package"
HOMEPAGE="http://www.gnustep.org"
LICENSE="LGPL-2.1"
DEPEND=">=dev-util/gnustep-make-1.5.1
	>=dev-libs/libxml2-2.4.23"
RDEPEND="virtual/libc"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
KEYWORDS="x86 -ppc ~sparc "
SLOT="0"

src_compile() {
	. /usr/GNUstep/System/Makefiles/GNUstep.sh
	econf \
		--with-xml-prefix=/usr \
		--with-gmp-include=/usr/include \
		--with-gmp-library=/usr/lib || die "./configure failed"
	make || die
}

src_install () {
	. /usr/GNUstep/System/Makefiles/GNUstep.sh
	make install \
		GNUSTEP_INSTALLATION_DIR=${D}/usr/GNUstep/System \
		INSTALL_ROOT_DIR=${D} \
		|| die "install failed"
}
