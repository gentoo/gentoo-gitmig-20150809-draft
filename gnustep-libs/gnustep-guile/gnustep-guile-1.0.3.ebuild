# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/gnustep-guile/gnustep-guile-1.0.3.ebuild,v 1.2 2004/07/23 15:01:16 fafhrd Exp $

DESCRIPTION="GNUstep Guile bridge"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 -ppc -sparc "
IUSE=""
DEPEND=">=gnustep-base/gnustep-base-1.3.4
	>=dev-util/guile-1.4-r3"
RDEPEND="virtual/libc"

src_compile() {

	# Source GNUstep Makefiles
	. /usr/GNUstep/System/Makefiles/GNUstep.sh

	# No options are needed to configure as environment variables
	# are pulled from the GNUstep Makefiles
	./configure || die "configure failed"

	# Parallel builds fail on gnustep-base so I will follow suit here
	make || die "make failed"
}

src_install () {

	. /usr/GNUstep/System/Makefiles/GNUstep.sh

	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/installpath.diff
	cd ${S}

	make INSTALL_ROOT_DIR=${D} \
		GNUSTEP_INSTALLATION_DIR=${D}/usr/GNUstep/System \
		install || die "install failed"

}
