# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm-user/lvm-user-1.0.8-r1.ebuild,v 1.2 2005/08/22 18:57:30 gustavoz Exp $

inherit flag-o-matic eutils

DESCRIPTION="User-land utilities for LVM (Logical Volume Manager) software"
HOMEPAGE="http://www.sistina.com/products_lvm.htm"
SRC_URI="ftp://ftp.sistina.com/pub/LVM/1.0/lvm_${PV}.tar.gz"

LICENSE=" || ( GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa -ppc sparc ~x86"
IUSE="static"

RDEPEND="!sys-fs/lvm2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0
	!>=sys-kernel/linux-headers-2.6
	virtual/linux-sources" # Use lvm2 for 2.6; lvm-user is for 2.4; see #90897.

S=${WORKDIR}/LVM/${PV}

pkg_setup() {
	check_KV
}

src_unpack() {
	unpack ${A}
	cd ${S}
	#epatch ${FILESDIR}/${P}-tmpfile.patch
}

src_compile() {
	local myconf

	filter-flags -fomit-frame-pointer #598

	if use static; then
		myconf="--enable-static_link"
	else
		# bug 29694 -- make static vgscan and vgchange for initrds
		epatch ${FILESDIR}/lvm-user-1.0.7-statics.patch
	fi

	# bug 99605 -- Compile with gcc-3.4
	epatch ${FILESDIR}/lvm-user-gcc-3.4.patch

	./configure --prefix=/ \
		--mandir=/usr/share/man \
		--with-kernel_dir="/usr/src/linux" \
		${myconf} || die "configure failed"

	# Fix flags
	sed -i -e "54,56d" -e "73d" make.tmpl

	# Fix tail
	# bug 27420 -- lvmcreate_initrd contains obsolete use of `tail -1'
	sed -i -e 's/tail -1/tail -n 1/' tools/lvmcreate_initrd

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

	dodoc ABSTRACT CONTRIBUTORS INSTALL LVM-HOWTO TODO CHANGELOG FAQ KNOWN_BUGS README WHATSNEW

	insinto /lib/rcscripts/addons
	newins ${FILESDIR}/lvm-user-start.sh lvm-start.sh
	newins ${FILESDIR}/lvm-user-stop.sh lvm-stop.sh

}
