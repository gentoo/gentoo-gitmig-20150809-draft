# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/iverilog/iverilog-0.6.1.ebuild,v 1.6 2004/06/04 23:24:25 dholm Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A Verilog simulation and synthesis tool"
SRC_URI="ftp://icarus.com/pub/eda/verilog/v0.6/verilog-${PV}.tar.gz"
HOMEPAGE="http://www.icarus.com/eda/verilog/"
DEPEND="dev-util/gperf"
PROVIDE="dev-lang/iverilog"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	mv verilog-${PV} ${P}
}

src_install() {
	make -j1 \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc *.txt COPYING INSTALL examples/*
}
