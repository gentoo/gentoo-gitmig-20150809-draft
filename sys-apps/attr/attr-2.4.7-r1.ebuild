# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-2.4.7-r1.ebuild,v 1.2 2003/09/07 00:48:11 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="xfs extended attributes tools"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz
		http://acl.bestbits.at/current/tar/${P}.src.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~amd64 ~mips ~ppc"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4.0.5
	virtual/glibc
	nls? ( sys-devel/gettext )
	>=sys-devel/gcc-3*"
RDEPEND="virtual/glibc"

IUSE="nls debug"

src_compile() {
	if use debug; then
		DEBUG=-DDEBUG
		OPTIMIZER="-g"
		CFLAGS=
		CXXFLAGS=
		export DEBUG OPTIMIZER CFLAGS CXXFLAGS
	else
		DEBUG=-DNDEBUG
		OPTIMIZER=""
		# note that CFLAGS is already inherited!
		export DEBUG OPTIMIZER
	fi

	local myconf="`use_enable nls gettext`"
	econf ${myconf} || die

	sed -i \
		-e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
		-e 's:-O1::' -e 's:../$(INSTALL) -S \(.*\) $(PKG_.*_DIR)/\(.*$\)::' \
		include/builddefs

	make || die
}

src_install() {
	dodir /lib
	dodir /usr/lib
	dodir /bin
	dodir /usr/bin

	make DIST_ROOT=${D} \
		install install-lib install-dev || die

	# install docs in correct place
	mv ${D}/usr/share/doc/attr ${D}/usr/share/doc/${PF}
	prepalldocs

	mv ${D}/usr/bin/* ${D}/bin
	mv ${D}/usr/lib/libattr.so* ${D}/lib

	dosym /lib/libattr.so /usr/lib/libattr.so
}
