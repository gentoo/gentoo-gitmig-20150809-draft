# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/odinmp/odinmp-0.167.2.ebuild,v 1.2 2004/06/24 22:48:27 agriffis Exp $

DESCRIPTION="The OdinMP OpenMP compiler"

HOMEPAGE="http://odinmp.imit.kth.se/"
SRC_URI="http://odinmp.imit.kth.se:81/odinmp/OdinMP.${PV}.tar.gz
	doc? ( http://odinmp.imit.kth.se:81/odinmp/odinmp_user_manual.pdf )"

LICENSE="OdinMP"
SLOT="0"

# The makefiles are only defined for x86 and sparc
KEYWORDS="~x86 ~sparc"

IUSE="doc"
DEPEND=">=sys-devel/flex-2.5.4
	>=sys-devel/bison-1.35"
RDEPEND=""
S=${WORKDIR}/OdinMP

src_unpack() {
	unpack OdinMP.${PV}.tar.gz

}

src_compile() {

	cd ${S}/build/linux-${ARCH}
	make all || die
}

src_install() {
	dobin build/linux-${ARCH}/odinmp
	dosym odinmp /usr/bin/intonecc
	dosym odinmp /usr/bin/intoneld
	dosym odinmp /usr/bin/odinmpcc
	dosym odinmp /usr/bin/odinmpas
	dosym odinmp /usr/bin/odinmpld

	dodoc README COPYRIGHT
	use doc && cp ${DISTDIR}/odinmp_user_manual.pdf ${D}usr/share/doc/${P}

}
