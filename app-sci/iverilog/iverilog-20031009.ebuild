# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/iverilog/iverilog-20031009.ebuild,v 1.3 2004/04/25 19:12:40 squinky86 Exp $

S="${WORKDIR}/verilog-${PV}"

DESCRIPTION="A Verilog simulation and synthesis tool"
SRC_URI="ftp://icarus.com/pub/eda/verilog/snapshots/verilog-${PV}.tar.gz"
HOMEPAGE="http://www.icarus.com/eda/verilog/"

DEPEND="dev-util/gperf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {

	econf || die "./configure failed"
	emake -j1 || die "emake failed"

}

src_install() {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc *.txt COPYING INSTALL examples/*

}
