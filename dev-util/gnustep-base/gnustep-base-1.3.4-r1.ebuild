# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-base/gnustep-base-1.3.4-r1.ebuild,v 1.5 2003/02/28 16:54:59 liquidx Exp $

DESCRIPTION="GNUstep base package"
HOMEPAGE="http://www.gnustep.org"
LICENSE="LGPL-2.1"
DEPEND=">=dev-util/gnustep-make-1.3.4"
RDEPEND="virtual/glibc"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
KEYWORDS="x86 -ppc -sparc "
SLOT="0"

src_compile() {
	. /usr/GNUstep/System/Makefiles/GNUstep.sh
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
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
