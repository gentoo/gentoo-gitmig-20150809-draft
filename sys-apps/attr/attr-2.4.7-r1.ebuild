# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-2.4.7-r1.ebuild,v 1.25 2004/08/02 17:46:33 avenj Exp $

inherit eutils

DESCRIPTION="Extended attributes tools"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz
	http://acl.bestbits.at/current/tar/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
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
		CFLAGS=
		CXXFLAGS=
		export DEBUG OPTIMIZER CFLAGS CXXFLAGS
	else
		DEBUG=-DNDEBUG
		OPTIMIZER=""
		# note that CFLAGS is already inherited!
		export DEBUG OPTIMIZER
	fi

	use sparc && unset PLATFORM
	use ppc && unset PLATFORM
	use ppc64 && unset PLATFORM
	use s390 && unset PLATFORM
	econf `use_enable nls gettext` || die

	sed -i \
		-e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
		-e 's:-O1::' \
		-e 's:../$(INSTALL) -S \(.*\) $(PKG_.*_DIR)/\(.*$\)::' \
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
