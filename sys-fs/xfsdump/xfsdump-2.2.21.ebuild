# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsdump/xfsdump-2.2.21.ebuild,v 1.1 2004/08/31 10:50:32 robbat2 Exp $

inherit eutils

DESCRIPTION="xfs dump/restore utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc -sparc ~mips ~alpha ~amd64 ~ia64"
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
		DEBUG=-DDEBUG
		OPTIMIZER="-g"
		CFLAGS=
		CXXFLAGS=
		export CFLAGS CXXFLAGS
	else
		DEBUG=-DNDEBUG
		OPTIMIZER="${CFLAGS}"
	fi
	export DEBUG OPTIMIZER

	# Some archs need the PLATFORM var unset
	if hasq ${ARCH} mips ppc sparc ppc64 s390; then
		unset PLATFORM
	fi

	local myconf
	LIBDIR="`get_libdir`"
	myconf="${myconf} --libdir=/${LIBDIR} --libexecdir=/usr/${LIBDIR}"
	myconf="${myconf} `use_enable !static shared`"
	econf \
		${myconf} \
		--sbindir=/sbin \
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
