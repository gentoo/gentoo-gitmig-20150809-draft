# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsdump/xfsdump-2.2.16.ebuild,v 1.9 2004/07/15 03:44:01 agriffis Exp $

DESCRIPTION="xfs dump/restore utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc -sparc ~mips amd64 ia64 alpha"
IUSE=""

DEPEND="sys-fs/e2fsprogs
	sys-fs/xfsprogs
	sys-apps/dmapi
	sys-apps/attr"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^PKG_DOC_DIR/s:=.*:= /usr/share/doc/${PF}:" \
		-e '/^GCFLAGS/s:-O1::' \
		-e '/^PKG_[A-Z]*_DIR/s:= := $(DESTDIR):' \
		include/builddefs.in \
		|| die
}

src_compile() {
	export OPTIMIZER="${CFLAGS}"
	export DEBUG=-DNDEBUG
	use sparc && unset PLATFORM

	econf \
		--libdir=/lib \
		--sbindir=/sbin \
		--libexecdir=/usr/lib \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	rm -f ${D}/usr/bin/xfsrestore
	rm -f ${D}/usr/bin/xfsdump
	dosym /sbin/xfsrestore /usr/bin/xfsrestore
	dosym /sbin/xfsdump /usr/bin/xfsdump
}
