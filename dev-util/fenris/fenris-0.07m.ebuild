# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/fenris/fenris-0.07m.ebuild,v 1.7 2004/04/25 21:35:28 vapier Exp $

inherit eutils

DESCRIPTION="Fenris is a tracer, GUI debugger, analyzer, partial decompiler and much more"
HOMEPAGE="http://razor.bindview.com/tools/fenris/"
SRC_URI="http://razor.bindview.com/tools/fenris/${PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=sys-apps/portage-2.0.47-r10
	sys-libs/libtermcap-compat
	app-misc/screen
	sys-libs/ncurses
	sys-devel/gdb"
RDEPEND="sys-apps/gawk"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/makefile.diff
	epatch ${FILESDIR}/build.diff
	epatch ${FILESDIR}/${P}-debian.patch
}

src_compile() {

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
	into /usr
	dobin fenris fprints getfprints ragnarok fenris-bug \
		ragsplit dress aegir nc-aegir spliter.pl

	einfo "These new tools are installed in /usr/bin:"
	einfo "fenris fprints getfprints ragnarok fenris-bug ragsplit "
	einfo "dress aegir nc-aegir spliter.pl"
	einfo "Please refer to the manpage for fenris for further information"
}
