# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sysfsutils/sysfsutils-0.2.0.ebuild,v 1.1 2003/10/11 20:21:43 azarah Exp $

IUSE=

S="${WORKDIR}/${PN}-${PV//./_}"
DESCRIPTION="System Utilities Based on Sysfs"
SRC_URI="mirror://sourceforge/linux-diag/${PN}-${PV//./_}.tar.gz"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"

	# Make sure we do not link with external libsysfs ..
	sed -i '/^LIBS/ s/-lsysfs//' cmd/Makefile

	emake || die
}

src_install() {
	einstall

	# We do not distribute this
	rm -f ${D}/usr/bin/dlist_test

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	# FIXME: cmd/GPL and lib/LGPL do not exist - should we
	#        then rather add them manually ?
	dodoc cmd/GPL lib/LGPL docs/libsysfs.txt
}

