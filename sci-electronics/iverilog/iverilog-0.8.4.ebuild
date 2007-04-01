# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/iverilog/iverilog-0.8.4.ebuild,v 1.1 2007/04/01 11:48:03 calchan Exp $

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

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix for bug #172919
	sed -i -e '/#  include <asm\/page.h>/d' vvp/main.cc || die "sed failed"

	# Fix tests
	mkdir -p lib/ivl
	touch lib/ivl/ivl
	sed -i -e 's/driver\/iverilog -B./IVERILOG_ROOT="." driver\/iverilog -B./' Makefile.in || die "sed failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		libdir=${D}/usr/$(get_libdir) \
		libdir64=${D}/usr/$(get_libdir) \
		vpidir=${D}/usr/$(get_libdir)/ivl \
		install || die "Installation failed."

	dodoc *.txt
	insinto /usr/share/doc/${PF}
	doins -r examples
}
