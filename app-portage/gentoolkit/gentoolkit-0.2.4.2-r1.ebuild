# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit/gentoolkit-0.2.4.2-r1.ebuild,v 1.6 2009/01/07 15:25:13 jer Exp $

EAPI=2

inherit eutils python

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz http://dev.gentoo.org/~fuzzyray/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="userland_GNU"

KEYWORDS="~alpha ~amd64 arm hppa ~ia64 m68k ~mips ~ppc ppc64 s390 sh sparc ~x86 -x86-fbsd"

DEPEND=">=sys-apps/portage-2.1.1_pre1
	>=dev-lang/python-2.0
	>=dev-lang/perl-5.6
	>=sys-apps/grep-2.4
	userland_GNU? ( sys-apps/debianutils )"

src_prepare() {
	epatch "${FILESDIR}/equery-0.2.4.2_use_expanded.patch"
}

src_install() {
	emake DESTDIR="${D}" install-gentoolkit || die "install-gentoolkit failed"

	# Create cache directory for revdep-rebuild
	dodir /var/cache/revdep-rebuild
	keepdir /var/cache/revdep-rebuild
	fowners root:root /var/cache/revdep-rebuild
	fperms 0700 /var/cache/revdep-rebuild
}

pkg_postinst() {
	# Make sure that our ownership and permissions stuck
	chown root:root "${ROOT}/var/cache/revdep-rebuild"
	chmod 0700 "${ROOT}/var/cache/revdep-rebuild"

	python_mod_optimize /usr/lib/gentoolkit
	echo
	elog "The default location for revdep-rebuild files has been moved"
	elog "to /var/cache/revdep-rebuild when run as root."
	elog
	elog "Another alternative to equery is app-portage/portage-utils"
	elog
	elog "For further information on gentoolkit, please read the gentoolkit"
	elog "guide: http://www.gentoo.org/doc/en/gentoolkit.xml"
	elog
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/gentoolkit
}
