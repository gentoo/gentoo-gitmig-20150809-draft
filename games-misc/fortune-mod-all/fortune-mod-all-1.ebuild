# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-all/fortune-mod-all-1.ebuild,v 1.1 2004/10/20 01:41:00 mr_bones_ Exp $

DESCRIPTION="Meta package for all fortune-mod packages, with exception of fortune-mod packages for specific non-english languages"

KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
LICENSE="as-is"
SLOT="0"
IUSE=""

RDEPEND="games-misc/fortune-mod
	games-misc/fortune-mod-bofh-excuses
	games-misc/fortune-mod-calvin
	games-misc/fortune-mod-debilneho
	games-misc/fortune-mod-dubya
	games-misc/fortune-mod-dune
	games-misc/fortune-mod-familyguy
	games-misc/fortune-mod-futurama
	games-misc/fortune-mod-gentoo-dev
	games-misc/fortune-mod-gentoo-forums
	games-misc/fortune-mod-hitchhiker
	games-misc/fortune-mod-homer
	games-misc/fortune-mod-humorixfortunes
	games-misc/fortune-mod-kernelcookies
	games-misc/fortune-mod-osfortune
	games-misc/fortune-mod-simpsons-chalkboard
	games-misc/fortune-mod-smac
	games-misc/fortune-mod-sp-fortunes
	games-misc/fortune-mod-starwars
	games-misc/fortune-mod-tao
	games-misc/fortune-mod-zx-error"
