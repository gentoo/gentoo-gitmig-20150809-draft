# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acl/acl-2.2.13-r2.ebuild,v 1.15 2004/07/19 02:41:48 robbat2 Exp $

DESCRIPTION="Access control list utilities, libraries and headers"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha arm ~hppa amd64 ia64 ppc64 s390"
IUSE="nls"

RDEPEND=">=sys-apps/attr-2.4
		 nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG
	use sparc && unset PLATFORM
	use ppc && unset PLATFORM
	use ppc64 && unset PLATFORM
	use s390 && unset PLATFORM
	autoconf || die

	./configure \
		`use_enable nls gettext` \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--libexecdir=/usr/lib \
		--libdir=/lib \
		|| die

	sed -i \
		-e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
		-e 's:-O1::' \
		include/builddefs || die "failed to update builddefs"

	emake || die
}

src_install() {
	make DIST_ROOT=${D} install install-dev install-lib || die
	#einstall DESTDIR=${D} install install-dev install-lib || die

	rm -f ${D}/usr/lib/libacl.so
	rm -f ${D}/lib/*a
	dosym /lib/libacl.so /usr/lib/libacl.so
	dosym /usr/lib/libacl.la /lib/libacl.la
	dosym /usr/lib/libacl.a /lib/libacl.a

	dodir /bin
	mv ${D}/usr/bin/* ${D}/bin/
	rmdir ${D}/usr/bin/
}
