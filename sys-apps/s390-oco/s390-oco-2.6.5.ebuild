# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/s390-oco/s390-oco-2.6.5.ebuild,v 1.10 2006/03/15 23:49:35 vapier Exp $

inherit linux-mod

STREAM="april2004"

DESCRIPTION="Object-code only (OCO) modules for s390"
HOMEPAGE="http://www.ibm.com/developerworks/linux/linux390/tape_3590-${PV}-s390-${STREAM}.shtml"
SRC_URI="mirror://gentoo/tape_3590-${PV}-s390x-${STREAM}.tar.gz
	mirror://gentoo/tape_3590-${PV}-s390-${STREAM}.tar.gz"

LICENSE="IBM-ILNWP"
SLOT="0"
KEYWORDS="s390"
IUSE=""

DEPEND="=sys-kernel/vanilla-sources-${PV}*"

S=${WORKDIR}

src_compile() {
	[[ ${CHOST} == s390x* ]] \
		&& mv tape_3590-${PV}-s390x-${STREAM}.ko tape_3590.ko \
		|| mv tape_3590-${PV}-s390-${STREAM}.ko tape_3590.ko
}

src_install() {
	insinto /etc/modules.d
	doins "${FILESDIR}"/s390-oco || die

	insinto /lib/modules/${KV}/OCO
	doins tape_3590.ko || die

	dodoc README
}
