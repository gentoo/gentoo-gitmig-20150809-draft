# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm-user/lvm-user-1.0.7-r1.ebuild,v 1.2 2004/01/13 00:11:41 agriffis Exp $

IUSE="static"

inherit flag-o-matic

S=${WORKDIR}/LVM/${PV}
DESCRIPTION="User-land utilities for LVM (Logical Volume Manager) software"
SRC_URI="ftp://ftp.sistina.com/pub/LVM/1.0/lvm_${PV}.tar.gz"
HOMEPAGE="http://www.sistina.com/products_lvm.htm"
KEYWORDS="~x86 ~amd64 -ppc ~sparc ~hppa alpha"

DEPEND=">=sys-apps/sed-4.0 virtual/linux-sources"
RDEPEND="${DEPEND}
	!sys-apps/lvm2"

LICENSE="GPL-2 | LGPL-2"
SLOT="0"

KS=/usr/src/linux

pkg_setup() {
	check_KV
}

src_compile() {
	local myconf

	# bug 598 -- -pipe used by default
	filter-flags "-fomit-frame-pointer -pipe"

	if use static; then
		myconf="--enable-static_link"
	else
		# bug 29694 -- make static vgscan and vgchange for initrds
		epatch ${FILESDIR}/lvm-user-1.0.7-statics.diff
	fi

	./configure --prefix=/ \
		--mandir=/usr/share/man \
		--with-kernel_dir="${KS}" ${myconf} || die "configure failed"

	# Fix flags
	sed -i -e "54,56d" -e "73d" make.tmpl

	make || die "Make failed"
}

src_install() {

	einstall sbindir=${D}/sbin libdir=${D}/lib

	if use static; then
		# already static, make symlinks
		dosym vgscan /sbin/vgscan.static
		dosym vgchange /sbin/vgchange.static
	else
		# install vgscan.static and vgchange.static
		into /
		dosbin ${S}/tools/{vgscan,vgchange}.static
	fi

	# no need for a static library in /lib
	dodir /usr/lib
	mv ${D}/lib/*.a ${D}/usr/lib

	dodoc ABSTRACT CONTRIBUTORS COPYING* INSTALL LVM-HOWTO TODO CHANGELOG FAQ KNOWN_BUGS README WHATSNEW
}
