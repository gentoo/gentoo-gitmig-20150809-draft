# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sysfsutils/sysfsutils-1.0.0.ebuild,v 1.8 2007/01/05 09:17:19 flameeyes Exp $

inherit eutils libtool

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"
SRC_URI="mirror://sourceforge/linux-diag/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips arm hppa ~amd64"
IUSE=""

DEPEND="virtual/libc"

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

	econf || die "./configure failed"

	emake || die
}

src_install() {
	einstall includedir=${D}/usr/include/sysfs || die

	# We do not distribute this
	rm -f ${D}/usr/bin/dlist_test

	dodoc AUTHORS ChangeLog NEWS README TODO
	# FIXME: cmd/GPL and lib/LGPL do not exist - should we
	#        then rather add them manually ?
	dodoc cmd/GPL lib/LGPL docs/libsysfs.txt
}
