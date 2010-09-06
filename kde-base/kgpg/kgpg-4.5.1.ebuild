# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgpg/kgpg-4.5.1.ebuild,v 1.1 2010/09/06 00:33:27 tampakrap Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE gpg keyring manager"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version app-crypt/dirmngr ; then
		elog "For improved key search functionality, install app-crypt/dirmngr."
	fi
}
