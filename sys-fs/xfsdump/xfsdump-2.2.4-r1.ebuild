# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsdump/xfsdump-2.2.4-r1.ebuild,v 1.5 2004/01/16 20:47:02 darkspecter Exp $

S=${WORKDIR}/${P}
DESCRIPTION="xfs dump/restore utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 amd64 ~mips ia64 ppc ~sparc"

DEPEND="sys-fs/e2fsprogs
	sys-fs/xfsprogs
	sys-apps/dmapi
	sys-apps/attr"

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG

	autoconf || die

	./configure \
	    --prefix=/usr \
	    --mandir=/usr/share/man \
	    --libdir=/lib \
	    --sbindir=/sbin \
	    --libexecdir=/usr/lib || die

	cp include/builddefs include/builddefs.orig
	sed -e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
	    -e "s:/usr/share/doc/${PN}:/usr/share/doc/${PF}:" -e 's:-O1::' \
	    -e 's:-S \(.*\) $(PKG_.*_DIR)/\(.*$\):-S \1 \2:' \
	    include/builddefs.orig > include/builddefs || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	rm -f ${D}/usr/bin/xfsrestore
	rm -f ${D}/usr/bin/xfsdump
	dosym /sbin/xfsrestore /usr/bin/xfsrestore
	dosym /sbin/xfsdump /usr/bin/xfsdump
}
