# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mkinitrd/mkinitrd-4.2.0.3.ebuild,v 1.3 2008/10/14 15:28:49 flameeyes Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Tools for creating initrd images"
HOMEPAGE="http://www.redhat.com/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="selinux"

DEPEND="dev-libs/popt
	virtual/os-headers"
RDEPEND="app-shells/bash"
PDEPEND="selinux? ( sys-apps/policycoreutils )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug 29694 -- Change vgwrapper to static vgscan and vgchange
	epatch "${FILESDIR}"/mkinitrd-lvm_statics.diff
	sed -i \
		-e '/^CFLAGS/s: -Werror::' \
		-e '/^CFLAGS/s: -g::' \
		-e '/^CFLAGS/s:=:+=:' \
		grubby/Makefile nash/Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" -C nash || die "nash compile failed."
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" -C grubby|| die "grubby compile failed."
}

src_install() {
	into /
	dosbin grubby/grubby nash/nash mkinitrd || die
	doman grubby/grubby.8 nash/nash.8 mkinitrd.8
}
