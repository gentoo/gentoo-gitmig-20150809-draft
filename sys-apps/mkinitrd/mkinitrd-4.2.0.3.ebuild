# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mkinitrd/mkinitrd-4.2.0.3.ebuild,v 1.1 2005/02/12 05:54:20 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Tools for creating initrd images"
HOMEPAGE="http://www.redhat.com/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="diet selinux"

DEPEND="dev-libs/popt
	virtual/os-headers
	diet? ( dev-libs/dietlibc )"
RDEPEND="app-shells/bash"
PDEPEND="selinux? ( sys-apps/policycoreutils )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug 29694 -- Change vgwrapper to static vgscan and vgchange
	epatch "${FILESDIR}"/mkinitrd-lvm_statics.diff
	sed -i \
		-e "/^CFLAGS/s: -Werror : ${CFLAGS} :" \
		-e "/^LDFLAGS/s:$: ${LDFLAGS}:" \
		grubby/Makefile nash/Makefile
}

src_compile() {
	use diet && append-flags -DUSE_DIET

	cd "${S}"/nash
	emake || die "nash compile failed."
	cd "${S}"/grubby
	emake || die "grubby compile failed."
}

src_install() {
	into /
	dosbin grubby/grubby nash/nash mkinitrd || die
	doman grubby/grubby.8 nash/nash.8 mkinitrd.8
}
