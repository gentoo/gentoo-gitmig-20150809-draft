# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-2.4.8.ebuild,v 1.9 2004/08/11 00:57:28 lv Exp $

inherit eutils

DESCRIPTION="Extended attributes tools"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/latest/cmd_tars/${P}.src.tar.gz
	http://acl.bestbits.at/current/tar/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
IUSE="nls debug"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4.0.5
	virtual/libc
	nls? ( sys-devel/gettext )
	sys-devel/libtool"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# More extensive man 2 documentation is found in the man-pages package,
	# so disable the installation of them
	epatch ${FILESDIR}/${PN}-no-man2pages.patch
}

src_compile() {
	if use debug; then
		DEBUG=-DDEBUG
		OPTIMIZER="-g"
		export DEBUG OPTIMIZER
	else
		DEBUG=-DNDEBUG
		OPTIMIZER=""
		export DEBUG OPTIMIZER
	fi

	local myconf="`use_enable nls gettext`"
	use sparc && unset PLATFORM
	use ppc && unset PLATFORM
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
	use amd64 && (
		dodir /lib64
		dodir /usr/lib64 )
	dodir /bin
	dodir /usr/bin

	make DIST_ROOT=${D} \
		install install-lib install-dev || die

	# install docs in correct place
	mv ${D}/usr/share/doc/attr ${D}/usr/share/doc/${PF}
	prepalldocs

	mv ${D}/usr/bin/* ${D}/bin

	# this file might be in lib... with the amd64 lib64 migration it might be
	# in lib64 too (maybe).
	if [ -a ${D}/usr/lib64/libattr.so.? ] ; then
		mv ${D}/usr/lib64/libattr.so* ${D}/lib64
		dosym /lib64/libattr.so /usr/lib64/libattr.so
	else
		mv ${D}/usr/lib/libattr.so* ${D}/lib
		dosym /lib/libattr.so /usr/lib/libattr.so
	fi
}
