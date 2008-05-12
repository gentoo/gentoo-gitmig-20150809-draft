# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgpg/kgpg-3.5.9.ebuild,v 1.4 2008/05/12 20:01:17 ranger Exp $

KMNAME=kdeutils
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE gpg keyring manager"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND="${RDEPEND}
	app-crypt/gnupg
	app-crypt/pinentry"

pkg_setup() {
	if ! built_with_use app-crypt/pinentry gtk && ! built_with_use app-crypt/pinentry qt3 ; then
		eerror "${PN} needs app-crypt/pinentry built with either the gtk or qt3 USE flag."
		eerror "Please enable either USE flag and re-install app-crypt/pinentry."
		die "app-crypt/pinentry needs to be rebuilt with gtk or qt3 support."
	fi

	kde_pkg_setup
}
