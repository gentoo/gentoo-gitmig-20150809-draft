# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-2.4.8.ebuild,v 1.7 2004/07/19 02:45:29 robbat2 Exp $

inherit eutils

DESCRIPTION="xfs extended attributes tools"
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
