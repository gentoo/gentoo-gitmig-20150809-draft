# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-base/gnustep-base-1.4.0.ebuild,v 1.1 2002/09/03 19:25:35 raker Exp $

DESCRIPTION="GNUstep base package"
HOMEPAGE="http://www.gnustep.org"
LICENSE="LGPL"
DEPEND=">=dev-util/gnustep-make-1.4.0
	>=dev-libs/libxml2-2.4.23"
RDEPEND="virtual/glibc"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
KEYWORDS="x86 -ppc sparc sparc64"
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
