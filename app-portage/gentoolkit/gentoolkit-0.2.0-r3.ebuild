# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit/gentoolkit-0.2.0-r3.ebuild,v 1.1 2005/11/10 21:37:57 fuzzyray Exp $

inherit eutils

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz http://dev.gentoo.org/~genone/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
#KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390 ~ppc-macos"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390 ppc-macos sh"

DEPEND=">=sys-apps/portage-2.0.51
	>=dev-lang/python-2.2
	>=dev-lang/perl-5.6
	>=sys-apps/grep-2.4
	sys-apps/debianutils"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/qpkg-deprecated.patch
	epatch ${FILESDIR}/revdep-rebuild.112099.patch
}

src_install() {
	make DESTDIR=${D} install-gentoolkit || die
}

pkg_postinst() {
	einfo "The following older scripts have been removed in this release:"
	einfo "    dep-clean, ewhich, mkebuild, pkg-clean, pkg-size"
	echo
	ewarn "The qpkg tool is deprecated in favor of equery and"
	ewarn "is no longer installed in ${ROOT}usr/bin in this release."
	ewarn "It is still available in ${ROOT}usr/lib/gentoolkit/bin/"
	ewarn "if you *really* want to use it."
	echo
}
