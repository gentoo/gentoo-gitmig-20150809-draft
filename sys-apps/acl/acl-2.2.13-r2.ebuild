# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acl/acl-2.2.13-r2.ebuild,v 1.7 2004/02/27 01:36:59 lu_zero Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Access control list utilities, libraries and headers"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~amd64 ppc sparc alpha ~hppa ~mips ia64 ppc64"

RDEPEND=">=sys-apps/attr-2.4
		 nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND} sys-devel/autoconf"

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG
	[ `use sparc` ] && unset PLATFORM
	[ `use ppc` ] && unset PLATFORM
	autoconf || die

	local myconf
	use nls && myconf="${myconf} --enable-gettext" || myconf="${myconf} --disable-gettext"

	./configure \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--libexecdir=/usr/lib \
		--libdir=/lib \
		${myconf}

	sed -e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
	-e 's:-O1::' -i include/builddefs || die "failed to update builddefs"

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
