# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/snns/snns-4.2-r2.ebuild,v 1.3 2003/09/06 22:23:06 msterret Exp $

MY_P="SNNSv${PV}"
DESCRIPTION="Stuttgart Neural Network Simulator"
HOMEPAGE="http://www-ra.informatik.uni-tuebingen.de/SNNS/"
SRC_URI="http://www-ra.informatik.uni-tuebingen.de/downloads/SNNS/${MY_P}.tar.gz
	doc? ( http://www-ra.informatik.uni-tuebingen.de/downloads/SNNS/${MY_P}.Manual.pdf )"

LICENSE="SNNS-${PV}"
KEYWORDS="x86"
SLOT="0"
IUSE="X doc"

DEPEND="X? ( virtual/x11 )
	virtual/glibc"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz

	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch || die "patch failed"
}

src_compile() {
	local myconf="--enable-global"
	local compileopts="compile-kernel compile-tools"

	if [ `use X` ] ; then
		myconf="${myconf} --with-x"
		compileopts="${compileopts} compile-xgui"
	else
		myconf="${myconf} --without-x"
	fi

	econf ${myconf}
	emake ${compileopts} || die "emake failed"
}

src_install() {
	for file in `find tools -type f -perm +100`; do
		dobin $file
	done

	if [ `use X` ] ; then
		newbin xgui/sources/xgui snns

		dodir /etc/env.d
		echo XGUILOADPATH=/usr/share/doc/${PF}/ > ${D}/etc/env.d/99snns

		insinto /usr/share/doc/${PF}
		doins default.cfg help.hdoc
	fi

	insinto /usr/share/doc/${PF}
	use doc && doins ${DISTDIR}/${MY_P}.Manual.pdf

	insinto /usr/share/doc/${PF}/examples
	doins examples/*

	doman man/man*/*
}
