# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/snns/snns-4.2.ebuild,v 1.1 2002/11/08 08:22:05 vapier Exp $

MY_P="SNNSv${PV}"
DESCRIPTION="Stuttgart Neural Network Simulator"
HOMEPAGE="http://www-ra.informatik.uni-tuebingen.de/SNNS/"
SRC_URI="http://www-ra.informatik.uni-tuebingen.de/downloads/SNNS/${MY_P}.tar.gz
	doc? ( http://www-ra.informatik.uni-tuebingen.de/downloads/SNNS/${MY_P}.Manual.pdf )"

LICENSE="SNNS-${PV}"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	virtual/glibc"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch || die "patch failed"
}

src_compile() {
	econf "--enable-global"
	emake || die "emake failed"
}

src_install() {
	for file in `find tools -type f -perm +100`; do
		dobin $file
	done
	newbin xgui/sources/xgui snns

	dodir /etc/env.d
	echo XGUILOADPATH=/usr/share/doc/${P}/ > ${D}/etc/env.d/99snns

	insinto /usr/share/doc/${P}
	doins default.cfg help.hdoc
	use doc && doins ${DISTDIR}/SNNSv4.2.Manual.pdf
	insinto /usr/share/doc/${P}/examples
	doins examples/*

	doman man/man*/*				 
}
