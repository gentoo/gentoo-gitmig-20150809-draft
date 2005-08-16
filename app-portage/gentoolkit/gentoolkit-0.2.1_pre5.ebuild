# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit/gentoolkit-0.2.1_pre5.ebuild,v 1.1 2005/08/16 19:16:24 fuzzyray Exp $

inherit eutils

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz http://dev.gentoo.org/~fuzzyray/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"

DEPEND=">=sys-apps/portage-2.0.51_pre21
	>=dev-lang/python-2.0
	>=dev-util/dialog-0.7
	>=dev-lang/perl-5.6
	>=sys-apps/grep-2.4
	userland_GNU? ( sys-apps/debianutils )"

src_install() {
	make DESTDIR=${D} install-gentoolkit || die
}

pkg_preinst() {
	# FIXME: remove old python runtime files, should use python.eclass
	rm -f ${ROOT}/usr/lib/gentoolkit/pym/gentoolkit.py[co] ${ROOT}/usr/lib/gentoolkit/pym/gentoolkit/*.py[co]
}

pkg_postinst() {
	echo
	einfo "The following older scripts have been removed in this release:"
	einfo "    dep-clean, ewhich, mkebuild, pkg-clean, pkg-size"
	echo
	ewarn "The qpkg and etcat tools are deprecated in favor of equery and"
	ewarn "are no longer installed in ${ROOT}usr/bin in this release."
	ewarn "They are still available in ${ROOT}usr/share/doc/${PF}/deprecated/"
	ewarn "if you *really* want to use them."
	echo
}
