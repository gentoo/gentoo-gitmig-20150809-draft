# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xfsdump/xfsdump-2.2.4.ebuild,v 1.3 2003/06/21 21:19:41 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="xfs dump/restore utilities"

SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/xfs"

KEYWORDS="x86 amd64"
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND="sys-apps/e2fsprogs sys-apps/xfsprogs sys-apps/dmapi sys-apps/attr"

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG
	
	autoconf || die
	
	./configure --prefix=/usr \
		    --libexecdir=/lib || die
	
	cp include/builddefs include/builddefs.orig
	sed -e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' -e "s:/usr/share/doc/${PN}:/usr/share/doc/${PF}:" -e 's:-O1::' -e 's:-S \(.*\) $(PKG_.*_DIR)/\(.*$\):-S \1 \2:' include/builddefs.orig > include/builddefs || die
	# 5) We now fix some absolute path symlinks in various makefiles
	local x
	for x in dump restore
	do
		cp ${x}/Makefile ${x}/Makefile.orig
		sed -e 's:$(INSTALL) -S $(PKG_.*_DIR)/\(.*\) \(.*/.*\):$(INSTALL) -S ../../sbin/\1 \2:' ${x}/Makefile.orig > ${x}/Makefile
	done
	
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
