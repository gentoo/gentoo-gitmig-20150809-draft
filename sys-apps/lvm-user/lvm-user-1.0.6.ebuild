# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lvm-user/lvm-user-1.0.6.ebuild,v 1.3 2003/01/05 02:01:38 aliz Exp $

IUSE="static"

inherit flag-o-matic

S=${WORKDIR}/LVM/${PV}
DESCRIPTION="User-land utilities for LVM (Logical Volume Manager) software"
SRC_URI="ftp://ftp.sistina.com/pub/LVM/1.0/lvm_${PV}.tar.gz"
HOMEPAGE="http://www.sistina.com/products_lvm.htm"
KEYWORDS="x86 -ppc ~sparc"

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND} >=sys-apps/sed-4.0"

LICENSE="GPL-2 | LGPL-2"
SLOT="0"

KS=/usr/src/linux

src_compile() {
	local myconf

	# bug 598 -- -pipe used by default
	filter-flags "-fomit-frame-pointer -pipe"	
	
	use static && myconf="--enable-static_link"

	./configure --prefix=/ \
		--mandir=/usr/share/man \
		--with-kernel_dir="${KS}" ${myconf} || die "configure failed"
	
	# Fix flags
	sed -i -e "54,56d" -e "73d" make.tmpl

	make || die "Make failed"
}

src_install() {

	einstall sbindir=${D}/sbin libdir=${D}/lib

	# no need for a static library in /lib
	dodir /usr/lib
	mv ${D}/lib/*.a ${D}/usr/lib

	dodoc ABSTRACT CONTRIBUTORS COPYING* INSTALL LVM-HOWTO TODO CHANGELOG FAQ KNOWN_BUGS README WHATSNEW 
}
