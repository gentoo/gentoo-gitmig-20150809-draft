# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/cctools-extras/cctools-extras-495.8.ebuild,v 1.2 2004/11/07 23:13:37 kito Exp $

DESCRIPTION="Extra cctools utils"
HOMEPAGE="http://darwinsource.opendarwin.org/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/cctools-${PV}.tar.gz"

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
	newbin check_dylib.NEW check_dylib || die "check_dylib failed"
	newbin checksyms.NEW checksyms || die "checksyms failed"
	newbin dylib_pcsampler.NEW dylib_pcsampler || die "dylib_pcsampler failed"
	newbin indr.NEW indr || die "indr failed"
	newbin seg_addr_table.NEW seg_addr_table || die "seg_addr_table failed"
	newbin seg_hack.NEW seg_hack || die "seg_hack failed"

	cd ${WORKDIR}/cctools-${PV}/man
	doman {check_dylib.1,checksyms.1,indr.1,seg_addr_table.1}
}