# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/cctools-extras/cctools-extras-525.ebuild,v 1.4 2005/02/19 06:00:27 kito Exp $

S=${WORKDIR}/cctools-${PV}

DESCRIPTION="Extra cctools"
HOMEPAGE="http://darwinsource.opendarwin.org/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/cctools-${PV}.tar.gz"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE="build"

DEPEND="sys-apps/bootstrap_cmds
		sys-libs/libstreams
		virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}/ld
	sed -i -e 's:seg_hack:${S}/misc/seg_hack.NEW:' Makefile
}

src_compile() {
	cd ${S}
	rm -rf ar as cbtlibs dyld file gprof libdyld mkshlib otool
	make SUBDIRS="libmacho libstuff misc" RC_OS=macos || die "make failed"

	cd ${S}/ld
	make RC_OS=macos kld_build || die "static kld build failed"
}

src_install() {
	cd ${S}/misc
	newbin check_dylib.NEW check_dylib || die "check_dylib failed"
	newbin checksyms.NEW checksyms || die "checksyms failed"
	newbin dylib_pcsampler.NEW dylib_pcsampler || die "dylib_pcsampler failed"
	newbin indr.NEW indr || die "indr failed"
	newbin seg_addr_table.NEW seg_addr_table || die "seg_addr_table failed"
	newbin seg_hack.NEW seg_hack || die "seg_hack failed"

	cd ${S}/ld/static_kld
	dolib.a *.a

	if ! use build; then
		cd ${S}/man
		doman {check_dylib.1,checksyms.1,indr.1,seg_addr_table.1}
	fi
}