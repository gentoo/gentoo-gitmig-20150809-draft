# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-2.0.9.ebuild,v 1.5 2002/10/13 08:42:10 bcowan Exp $

S=${WORKDIR}/${P}

DESCRIPTION="xfs extended attributes tools"

SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/xfs"

KEYWORDS="~x86"
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG
	
	autoconf || die
	
	./configure --prefix=/usr \
		    --libexecdir=/lib || die
	
	cp include/builddefs include/builddefs.orig
	sed -e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
		-e "s:/usr/share/doc/${PN}:/usr/share/doc/${PF}:" \
		-e 's:-O1::' \
		-e 's:../$(INSTALL) -S \(.*\) $(PKG_.*_DIR)/\(.*$\)::' \
		include/builddefs.orig > include/builddefs || die
	
	emake || die
}

src_install() {
	make DESTDIR=${D} install install-lib install-dev || die
	dosym /lib/libattr.a /usr/lib/libattr.a
	dosym /lib/libattr.la /usr/lib/libattr.la
	dosym /usr/lib/libattr.so /lib/libattr.so
}
