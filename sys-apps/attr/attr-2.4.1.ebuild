# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-2.4.1.ebuild,v 1.2 2003/04/13 15:18:32 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="xfs extended attributes tools"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz
	http://acl.bestbits.at/current/tar/${P}.src.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~mips"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4.0.5
	virtual/glibc
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}

#	epatch ${WORKDIR}/${P}-gentoo-suse-copy.patch
	if [ -z "`use nls`" ]
	then
		epatch ${FILESDIR}/${P}-gettext.diff
		sed -i "s: po::" Makefile
	fi
}

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG
	
	autoconf || die
	
	econf || die
	    
	sed -i \
		-e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
		-e 's:-O1::' -e 's:../$(INSTALL) -S \(.*\) $(PKG_.*_DIR)/\(.*$\)::' \
		include/builddefs
	
	make || die
}

src_install() {
	make DIST_ROOT=${D} \
		install install-lib install-dev || die
	
	dodir /lib
	dosym /usr/lib/libattr.a /lib/libattr.a
	dosym /usr/lib/libattr.la /lib/libattr.la
	dosym /lib/libattr.so /usr/lib/libattr.so
	dosym libattr.so.1 /usr/lib/libattr.so
}
