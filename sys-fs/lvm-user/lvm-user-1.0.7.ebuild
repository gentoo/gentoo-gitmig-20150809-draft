# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm-user/lvm-user-1.0.7.ebuild,v 1.6 2004/10/03 09:52:54 vapier Exp $

inherit flag-o-matic

DESCRIPTION="User-land utilities for LVM (Logical Volume Manager) software"
HOMEPAGE="http://www.sistina.com/products_lvm.htm"
SRC_URI="ftp://ftp.sistina.com/pub/LVM/1.0/lvm_${PV}.tar.gz"

LICENSE="GPL-2 | LGPL-2"
SLOT="0"
KEYWORDS="x86 -ppc sparc hppa amd64"
IUSE="static"

RDEPEND="!sys-fs/lvm2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0
	virtual/linux-sources"

S=${WORKDIR}/LVM/${PV}

pkg_setup() {
	check_KV
}

src_compile() {
	local myconf

	# bug 598 -- -pipe used by default
	filter-flags "-fomit-frame-pointer -pipe"

	use static && myconf="--enable-static_link"

	./configure --prefix=/ \
		--mandir=/usr/share/man \
		--with-kernel_dir="/usr/src/linux" ${myconf} || die "configure failed"

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
