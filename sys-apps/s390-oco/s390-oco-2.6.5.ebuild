# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/s390-oco/s390-oco-2.6.5.ebuild,v 1.5 2005/03/30 05:15:52 vapier Exp $

DESCRIPTION="Object-code only (OCO) modules for s390"
SRC_URI="s390x? ( tape_3590-2.6.5-s390x-april2004.tar.gz )
	!s390x? ( tape_3590-2.6.5-s390-april2004.tar.gz )"
HOMEPAGE="http://www10.software.ibm.com/developerworks/opensource/linux390/tape_3590-2.6.5-s390-april2004.shtml"
LICENSE="IBM-ILNWP"
KEYWORDS="~s390"
SLOT="${KV}"
DEPEND="~sys-kernel/vanilla-sources-2.6.5"
IUSE=""

RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo ""
	einfo " o ${HOMEPAGE}"
	einfo ""
	einfo "and put it into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	check_KV || die "Cannot find kernel in /usr/src/linux"
}

src_compile() {
	cd ${WORKDIR}
	mv tape3590-2.6.5-s390*-01-april2004.ko tape_3590.ko
}

src_install() {
	dodir /etc/modules.d
	insinto /etc/modules.d
	doins ${FILESDIR}/s390-oco

	cd ${WORKDIR}
	dodir /lib/modules/${KV}/OCO
	insinto /lib/modules/${KV}/OCO
	doins tape_3590.ko

	dodoc README LICENSE
}
