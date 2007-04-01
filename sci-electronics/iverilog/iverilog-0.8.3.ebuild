# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/iverilog/iverilog-0.8.3.ebuild,v 1.2 2007/04/01 09:19:40 calchan Exp $

inherit multilib

S="${WORKDIR}/verilog-${PV}"

DESCRIPTION="A Verilog simulation and synthesis tool"
SRC_URI="ftp://icarus.com/pub/eda/verilog/v${PV:0:3}/verilog-${PV}.tar.gz"
HOMEPAGE="http://www.icarus.com/eda/verilog/"

DEPEND=""
RDEPEND=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}

	# Fix for bug #172919
	sed -i \
		-e '/#  include <asm\/page.h>/d' \
		-e '/unsigned siz, rss, shd;/a\
	    long PAGE_SIZE = sysconf(_SC_PAGESIZE);\
	    if (PAGE_SIZE==-1) PAGE_SIZE=0;
'		${S}/vvp/main.cc
}

src_compile() {
	econf || die "Configuration failed"
	emake -j1 || die "Compilation failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		libdir=${D}/usr/$(get_libdir) \
		libdir64=${D}/usr/$(get_libdir) \
		vpidir=${D}/usr/$(get_libdir)/ivl \
		install || die "Installation failed"

	dodoc *.txt COPYING INSTALL examples/*
}
