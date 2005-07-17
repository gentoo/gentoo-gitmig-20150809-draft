# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit/gentoolkit-0.2.0.ebuild,v 1.4 2005/07/17 15:19:28 matsuu Exp $

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

src_install() {
	make DESTDIR=${D} install-gentoolkit || die
}

pkg_postinst() {
	einfo "The following older scripts have been removed in this release:"
	einfo "    dep-clean, ewhich, mkebuild, pkg-clean, pkg-size"
}
