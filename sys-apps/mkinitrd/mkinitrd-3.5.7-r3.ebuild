# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mkinitrd/mkinitrd-3.5.7-r3.ebuild,v 1.2 2004/10/22 02:59:41 agriffis Exp $

inherit eutils

DESCRIPTION="Tools for creating initrd images"
HOMEPAGE="http://www.redhat.com"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~ia64"
IUSE="diet selinux"

DEPEND="dev-libs/popt
	virtual/os-headers
	x86? ( diet? ( dev-libs/dietlibc ) )"
RDEPEND="app-shells/bash"
PDEPEND="selinux? ( sys-apps/policycoreutils )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix for coreutils tail behavior
	sed -i -e 's/tail -1/tail -n 1/' mkinitrd || die "sed for tail -1 failed."

	# bug 29694 -- Change vgwrapper to static vgscan and vgchange
	epatch ${FILESDIR}/mkinitrd-lvm_statics.diff

	# bug 35138
	epatch ${FILESDIR}/mkinitrd-3.5.7-dietssp.patch

	# SELinux policy load
	use selinux && epatch ${FILESDIR}/mkinitrd-selinux.diff

	# we don't always need diet support.
	use diet || sed -i -e s/'=diet '/=/g ${S}/nash/Makefile
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
