# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-1.2-r2.ebuild,v 1.1 2003/10/21 02:25:21 pebenito Exp $

IUSE=""

DESCRIPTION="SELinux library (libselinux)"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="sys-apps/attr"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/libselinux-1.2-gentoo.diff
	epatch ${FILESDIR}/libselinux-1.2-const.diff

	# use sys-apps/attr with headers older than 2.4.20
	has_version '>=sys-kernel/linux-headers-2.4.20' && epatch ${FILESDIR}/libselinux-1.2-attr.diff
}

src_compile() {
	cd ${S}/src
	emake EXTRA_CFLAGS="${CFLAGS}" || die "libselinux compile failed."

	cd ${S}/utils
	emake EXTRA_CFLAGS="${CFLAGS}" || die "Utilities compile failed."
}

src_install() {
	make DESTDIR="${D}" install
}

