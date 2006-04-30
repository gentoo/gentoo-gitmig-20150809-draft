# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-uffi/cl-uffi-1.5.10.ebuild,v 1.1 2006/04/30 05:42:13 mkennedy Exp $

inherit common-lisp multilib

DESCRIPTION="Portable FFI library for Common Lisp."
HOMEPAGE="http://uffi.med-info.com/"
SRC_URI="http://files.b9.com/uffi/uffi-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}/uffi-${PV}

CLPACKAGE=uffi

src_install() {
	dodir /usr/share/common-lisp/systems
	insinto /usr/share/common-lisp/source/uffi/src
	doins src/*.lisp
	insinto /usr/share/common-lisp/source/uffi
	doins uffi.asd uffi-tests.asd
	dosym /usr/share/common-lisp/source/uffi/uffi.asd \
		/usr/share/common-lisp/systems/uffi.asd
	dodoc AUTHORS ChangeLog INSTALL LICENSE NEWS README TODO doc/uffi.pdf doc/COPYING.GFDL
	tar xfz doc/html.tar.gz
	dohtml html/*
	for i in examples benchmarks ; do
		insinto /usr/share/doc/${P}/$i
		doins $i/*
	done
}
