# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/iverilog/iverilog-0.8.ebuild,v 1.2 2005/01/12 20:39:41 plasmaroo Exp $

S="${WORKDIR}/verilog-${PV}"

DESCRIPTION="A Verilog simulation and synthesis tool"
SRC_URI="ftp://icarus.com/pub/eda/verilog/v${PV}/verilog-${PV}.tar.gz"
HOMEPAGE="http://www.icarus.com/eda/verilog/"

DEPEND="dev-util/gperf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
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
