# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acl/acl-20020330.ebuild,v 1.6 2002/07/21 18:17:16 gerk Exp $

S=${WORKDIR}/cmd/${PN}
DESCRIPTION="XFS dump/restore utilities"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/xfs-cmd-${PV}.tar.bz2"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND="virtual/glibc sys-devel/autoconf >=sys-apps/attr-20020330 sys-devel/make"
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
	sed -e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
		-e "s:/usr/share/doc/${PN}:/usr/share/doc/${PF}:" \
		-e 's:-O1::' \
		include/builddefs.orig > include/builddefs || die
#		-e 's:-S \(.*\) $(PKG_.*_DIR)/\(.*$\):-S \1 \2:' \
	emake || die
}

src_install() {
	make DESTDIR=${D} install install-dev install-lib || die
	#fix freaky symlinks
	cd ${D}/usr/lib
	rm libacl.so
	ln -s ../../lib/libacl.so libacl.so
	cd ${D}/lib
	rm *a
	ln -s ../usr/lib/libacl.la libacl.la
	ln -s ../usr/lib/libacl.a libacl.a
}
