# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsdump/xfsdump-2.2.24.ebuild,v 1.2 2004/12/04 01:04:10 vapier Exp $

inherit eutils

DESCRIPTION="xfs dump/restore utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ~mips ~ppc -sparc x86"
IUSE="debug static"

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
	if use debug; then
		export DEBUG=-DDEBUG
	else
		export DEBUG=-DNDEBUG
	fi
	export OPTIMIZER="${CFLAGS}"

	# Some archs need the PLATFORM var unset
	unset PLATFORM

	econf \
		--libdir=/$(get_libdir) \
		--libexecdir=/usr/$(get_libdir) \
		--sbindir=/sbin \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dosym ../../sbin/xfsrestore /usr/bin/xfsrestore
	dosym ../../sbin/xfsdump /usr/bin/xfsdump
}
