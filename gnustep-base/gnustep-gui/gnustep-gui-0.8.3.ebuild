# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-gui/gnustep-gui-0.8.3.ebuild,v 1.2 2004/07/23 15:00:58 fafhrd Exp $

DESCRIPTION="GNUstep AppKit implementation"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 -ppc -sparc"
IUSE=""
DEPEND=">=gnustep-base/gnustep-base-1.5.1
	>=media-libs/tiff-3.5.7
	>=media-libs/jpeg-6b-r2"
PDEPEND=">=gnustep-base/gnustep-back-${PV}"

src_compile() {
	. /usr/GNUstep/System/Makefiles/GNUstep.sh
	./configure --prefix=/usr/GNUstep \
		--with-jpeg-library=/usr/lib \
		--with-jpeg-include=/usr/include \
		--with-tiff-library=/usr/lib \
		--with-tiff-include=/usr/include \
		|| die "configure failed"
	make LD_LIBRARY_PATH=$LD_LIBRARY_PATH || die
}

src_install () {
	. /usr/GNUstep/System/Makefiles/GNUstep.sh
	make \
		GNUSTEP_INSTALLATION_DIR=${D}/usr/GNUstep/System \
		INSTALL_ROOT_DIR=${D} \
		install || die "install failed"
}
