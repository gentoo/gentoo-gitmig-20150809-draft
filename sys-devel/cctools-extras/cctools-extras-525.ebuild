# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/cctools-extras/cctools-extras-525.ebuild,v 1.1 2004/11/07 22:56:00 kito Exp $

DESCRIPTION="Extra cctools utils"
HOMEPAGE="http://darwinsource.opendarwin.org/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/cctools-${PV}.tar.gz"
RESTRICT="nomirror"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE=""

DEPEND=""

src_compile() {
	cd ${WORKDIR}/cctools-${PV}
	rm -rf ar as cbtlibs dyld file gprof ld libdyld libmacho mkshlib otool
	make SUBDIRS="libstuff misc" || die "make failed"
}

src_install() {
	cd ${WORKDIR}/cctools-${PV}/misc
	newbin check_dylib.NEW check_dylib
	newbin checksyms.NEW checksyms
	newbin dylib_pcsampler.NEW dylib_pcsampler
	newbin indr.NEW indr
	newbin seg_addr_table.NEW seg_addr_table
	newbin seg_hack.NEW seg_hack

	cd ${WORKDIR}/cctools-${PV}/man
	doman {check_dylib.1,checksyms.1,indr.1,seg_addr_table.1}
}