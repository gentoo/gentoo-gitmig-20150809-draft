# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit/gentoolkit-0.2.4_pre8.ebuild,v 1.5 2009/05/01 03:22:55 fuzzyray Exp $

inherit eutils python

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz http://dev.gentoo.org/~fuzzyray/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="userland_GNU"

KEYWORDS="~sparc-fbsd ~x86-fbsd"

DEPEND=">=sys-apps/portage-2.1.1_pre1
	>=dev-lang/python-2.0
	>=dev-lang/perl-5.6
	>=sys-apps/grep-2.4
	userland_GNU? ( sys-apps/debianutils )"
RDEPEND="$DEPEND"

src_install() {
	emake DESTDIR="${D}" install-gentoolkit || die "install-gentoolkit failed"
}

pkg_postinst() {
	python_mod_optimize /usr/lib/gentoolkit
	echo
	ewarn "This version of gentoolkit contains a rewritten version of"
	ewarn "revdep-rebuild."
	ewarn
	elog "Another alternative to equery is app-portage/portage-utils"
	elog
	elog "For further information on gentoolkit, please read the gentoolkit"
	elog "guide: http://www.gentoo.org/doc/en/gentoolkit.xml"
	elog
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/gentoolkit
}
