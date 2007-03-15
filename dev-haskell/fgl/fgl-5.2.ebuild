# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/fgl/fgl-5.2.ebuild,v 1.4 2007/03/15 02:18:01 jer Exp $

inherit ghc-package

DESCRIPTION="A functional graph library for Haskell."
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI=""
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 hppa sparc x86"
IUSE=""

DEPEND="=virtual/ghc-6.4*"

pkg_setup () {
	ghc-package_pkg_setup
	einfo "This library is already provided by ghc. This ebuild does nothing."
}

src_install () {
	dodir "$(ghc-libdir)"
	touch "${D}/$(ghc-libdir)/.${P}.ghc-updater"
}
