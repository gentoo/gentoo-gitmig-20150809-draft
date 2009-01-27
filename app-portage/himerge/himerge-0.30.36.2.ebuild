# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/himerge/himerge-0.30.36.2.ebuild,v 1.1 2009/01/27 04:44:37 araujo Exp $

EAPI="2"

inherit base haskell-cabal

DESCRIPTION="Haskell Graphical User Interface for the Gentoo's Portage System."
HOMEPAGE="http://www.haskell.org/himerge/"
SRC_URI="http://www.haskell.org/himerge/release/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.8.2
	|| ( >=dev-haskell/gtk2hs-0.9.12.1[firefox]
		>=dev-haskell/gtk2hs-0.9.12.1[seamonkey]
		>=dev-haskell/gtk2hs-0.9.12.1[xulrunner] )
	dev-haskell/parallel
	dev-haskell/regex-posix
	>=app-portage/eix-0.9.3
	>=app-portage/gentoolkit-0.2.3
	>=app-portage/portage-utils-0.1.28
	>=dev-haskell/filepath-1.0"
RDEPEND=""

RESTRICT="strip"

pkg_setup() {
	if has_version '>=www-client/mozilla-firefox-3.0'; then
		if ! built_with_use dev-haskell/gtk2hs xulrunner; then
			echo
			eerror "Himerge requires gtk2hs to be compiled with the xulrunner
			USE flag if you have mozilla-firefox >= 3.0."
			die "gtk2hs missing web browser support."
		fi
	fi
}

src_install() {
	cabal_src_install
	# Give suid privileges.
	fperms 4111 /usr/bin/hima
}

pkg_postinst() {
	enewgroup himerge
	ewarn "In order to run this Himerge version you have to"
	ewarn "be in the 'himerge' group."
	case ${CHOST} in
		*-darwin*) ewarn "Just run 'niutil -appendprop / /groups/himerge users <USER>'";;
		*-freebsd*|*-dragonfly*) ewarn "Just run 'pw groupmod himerge -m <USER>'";;
		*) ewarn "Just run 'gpasswd -a <USER> himerge', then have <USER> re-login.";;
	esac
	echo
}
