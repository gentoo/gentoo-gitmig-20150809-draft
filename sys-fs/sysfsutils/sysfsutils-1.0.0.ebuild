# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sysfsutils/sysfsutils-1.0.0.ebuild,v 1.2 2004/03/23 01:53:18 kumba Exp $

inherit eutils libtool gnuconfig

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"
SRC_URI="mirror://sourceforge/linux-diag/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~hppa ~amd64 ~sparc ~mips"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Make sure we do not link with external libsysfs ..
	epatch ${FILESDIR}/${P}-dont-check-for-libsysfs.patch
	aclocal
	autoconf
	automake

	elibtoolize
}

src_compile() {

	# Detect mips systems properly
	use mips && gnuconfig_update

	econf || die "./configure failed"

	emake || die
}

src_install() {
	einstall includedir=${D}/usr/include/sysfs || die

	# We do not distribute this
	rm -f ${D}/usr/bin/dlist_test

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	# FIXME: cmd/GPL and lib/LGPL do not exist - should we
	#        then rather add them manually ?
	dodoc cmd/GPL lib/LGPL docs/libsysfs.txt
}
