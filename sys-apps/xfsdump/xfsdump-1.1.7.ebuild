# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xfsdump/xfsdump-1.1.7.ebuild,v 1.7 2003/06/21 21:19:41 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="xfs dump/restore utilities"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/latest/cmd_tars/${P}.src.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
KEYWORDS="x86 amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc sys-devel/autoconf sys-devel/make sys-apps/e2fsprogs sys-apps/xfsprogs sys-apps/dmapi sys-apps/attr"
RDEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	export OPTIMIZER="${CFLAGS}"
	export DEBUG=-DNDEBUG
	autoconf || die
	./configure --prefix=/usr || die
	# 1) add a ${DESTDIR} prefix to all install paths so we can relocate during the "install" phase
	# 2) we also set the /usr/share/doc/ directory to the correct value.
	# 3) we remove a hard-coded "-O1"
	# 4) we fix some Makefile-created library symlinks that contains absolute paths
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
