# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mkinitrd/mkinitrd-3.5.7-r1.ebuild,v 1.2 2003/10/27 19:01:58 pebenito Exp $

IUSE="selinux"

DESCRIPTION="Tools for creating initrd images"
HOMEPAGE="http://www.redhat.com"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-libs/popt
	>=sys-kernel/linux-headers-2.4.19-r1
	x86? ( dev-libs/dietlibc )"

RDEPEND="app-shells/bash"

PDEPEND="selinux? ( sys-apps/policycoreutils )"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	cd ${S}

	# Fix for coreutils tail behavior
	sed -i -e 's/tail -1/tail -n 1/' mkinitrd || die "sed for tail -1 failed"

	# SELinux policy load
	use selinux && epatch ${FILESDIR}/mkinitrd-selinux.diff
}

src_compile() {
	cd ${S}/nash
	emake || die "nash compile failed."

	cd ${S}/grubby
	emake || die "grubby compile failed."
}

src_install() {
	into /
	dosbin ${S}/grubby/grubby ${S}/nash/nash ${S}/mkinitrd
	doman ${S}/grubby/grubby.8 ${S}/nash/nash.8 ${S}/mkinitrd.8
}
