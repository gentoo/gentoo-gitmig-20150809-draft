# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/fenris/fenris-0.07m.ebuild,v 1.3 2003/01/21 19:31:58 mholzer Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Fenris is a tracer, GUI debugger, analyzer, partial decompiler and much more"
HOMEPAGE="http://razor.bindview.com/tools/fenris/"
SRC_URI="http://razor.bindview.com/tools/fenris/fenris.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc
	app-misc/screen
	sys-libs/ncurses
	sys-devel/gdb"
RDEPEND="sys-apps/gawk"

src_unpack() {
		unpack ${PN}.tgz ; cd ${S}	
}

src_compile() {
		patch -p0 < ${FILESDIR}/makefile.diff || die "can't patch Makefile"
		patch -p0 < ${FILESDIR}/build.diff || die "can't patch Build"

		# We need to obtain libc version, this should be a reliable way :)
		# because internal script doesn't detect libc version during the emerge
		LIBC=`ls /lib/libc-* | awk -F- '{print $2}' | awk -F.so '{print $1}'`

		make all CFLAGS="$CFLAGS" LIBCVER=${LIBC} || die
}

src_install() {

		# We are doing make install by hand
		cd ${S}
		dodir /usr/share/fenris

		# Man pages
		doman doc/man/*

		# Documents
		dodir /usr/share/fenris/doc
		insinto /usr/share/fenris/doc
		doins doc/*

		# Fingeprints
		insinto /etc
		doins fnprints.dat

		# Executables
		exeinto /usr/bin
		doexe fenris fprints getfprints ragnarok fenris-bug ragsplit dress aegir nc-aegir spliter.pl

		einfo "These new tools are installed in /usr/bin:"
		einfo "fenris fprints getfprints ragnarok fenris-bug ragsplit dress aegir nc-aegir spliter.pl"
		einfo "Please refer to the manual (i.e: man fenris) for further informations"
}
