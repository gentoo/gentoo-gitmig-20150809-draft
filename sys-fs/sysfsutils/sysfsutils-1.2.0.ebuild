# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sysfsutils/sysfsutils-1.2.0.ebuild,v 1.4 2005/03/03 16:52:31 corsair Exp $

inherit eutils libtool gnuconfig

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"
SRC_URI="mirror://sourceforge/linux-diag/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~arm ~hppa ~amd64 ~alpha ~ppc64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	# Detect mips systems properly
	gnuconfig_update

	econf || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# We do not distribute this
	rm -f ${D}/usr/bin/dlist_test

	dodoc AUTHORS ChangeLog NEWS README TODO
	# FIXME: cmd/GPL and lib/LGPL do not exist - should we
	#        then rather add them manually ?
	dodoc cmd/GPL lib/LGPL docs/libsysfs.txt
}
