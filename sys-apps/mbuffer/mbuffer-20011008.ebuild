# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mbuffer/mbuffer-20011008.ebuild,v 1.2 2003/09/03 20:41:21 max Exp $

DESCRIPTION="M(easuring)buffer is a replacement for buffer with additional functionality."
HOMEPAGE="http://www.rcs.ei.tum.de/~maierkom/privat/software/mbuffer/"
SRC_URI="http://www.rcs.ei.tum.de/~maierkom/privat/software/mbuffer/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="debug nls"

DEPEND="virtual/glibc"

src_compile() {
	local myconf
	myconf="${myconf} `use_enable debug`"
	myconf="${myconf} `use_enable nls`"

	econf ${myconf}
	emake || die "compile problem"
}

src_install() {
	einstall exec_prefix="${D}/usr"
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}
