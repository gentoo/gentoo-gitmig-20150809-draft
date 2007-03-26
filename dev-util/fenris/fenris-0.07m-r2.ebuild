# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/fenris/fenris-0.07m-r2.ebuild,v 1.9 2007/03/26 08:09:34 antarus Exp $

inherit eutils

DESCRIPTION="Fenris is a tracer, GUI debugger, analyzer, partial decompiler and much more"
HOMEPAGE="http://razor.bindview.com/tools/fenris/"
# dev-snapshot: http://lcamtuf.coredump.cx/fenris/fenris.tgz (2004/01/08)
SRC_URI="mirror://gentoo/${P}-r1.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/libtermcap-compat
	app-misc/screen
	sys-libs/ncurses
	dev-libs/openssl
	virtual/os-headers
	sys-devel/gdb"
RDEPEND="sys-apps/gawk"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/makefile.diff
	epatch ${FILESDIR}/build.diff
	epatch ${FILESDIR}/${P}-debian.patch
	epatch ${FILESDIR}/${P}-noansiart.patch # disable ascii art
	epatch ${FILESDIR}/${P}-dress.c.patch # update for latest binutils
	epatch ${FILESDIR}/${P}-speedup.patch # to speed up makefile
	epatch ${FILESDIR}/${P}-fnprints.patch # move fnprints to /etc/fenris
	epatch ${FILESDIR}/${P}-nls.patch # allow build to run on non-ascii locales

	cd ${S}/doc/man
	sed -i 's:/etc/fnprints.dat:/etc/fenris/fnprints.dat:' -i *
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
	insinto /etc/fenris
	doins fnprints.dat
	dodir /etc/env.d
	echo 'CONFIG_PROTECT_MASK="/etc/fenris"' > ${D}/etc/env.d/99fenris

	# Executables
	into /usr
	dobin fenris fprints getfprints ragnarok fenris-bug \
		ragsplit dress aegir nc-aegir spliter.pl

}

pkg_postinst() {
	elog "These new tools are installed in /usr/bin:"
	elog "fenris fprints getfprints ragnarok fenris-bug ragsplit "
	elog "dress aegir nc-aegir spliter.pl"
	elog "Please refer to the manpage for fenris for further information"
}
