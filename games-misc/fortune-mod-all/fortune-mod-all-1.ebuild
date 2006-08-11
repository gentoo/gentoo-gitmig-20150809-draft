# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-all/fortune-mod-all-1.ebuild,v 1.10 2006/08/11 02:26:47 vapier Exp $

DESCRIPTION="Meta package for all fortune-mod packages."
HOMEPAGE="http://www.gentoo.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="offensive"

RDEPEND="games-misc/fortune-mod
	games-misc/fortune-mod-at-linux
	games-misc/fortune-mod-bofh-excuses
	games-misc/fortune-mod-calvin
	games-misc/fortune-mod-chucknorris
	games-misc/fortune-mod-cs
	linguas_sk? ( games-misc/fortune-mod-debilneho )
	games-misc/fortune-mod-dubya
	games-misc/fortune-mod-dune
	games-misc/fortune-mod-familyguy
	games-misc/fortune-mod-firefly
	games-misc/fortune-mod-futurama
	games-misc/fortune-mod-fvl
	games-misc/fortune-mod-gentoo-dev
	games-misc/fortune-mod-gentoo-forums
	games-misc/fortune-mod-hitchhiker
	games-misc/fortune-mod-homer
	games-misc/fortune-mod-humorixfortunes
	linguas_it? ( games-misc/fortune-mod-it )
	games-misc/fortune-mod-kernelcookies
	games-misc/fortune-mod-martin-piskernig
	games-misc/fortune-mod-norbert-tretkowski
	games-misc/fortune-mod-osfortune
	games-misc/fortune-mod-powerpuff
	games-misc/fortune-mod-pqf
	games-misc/fortune-mod-rss
	games-misc/fortune-mod-simpsons-chalkboard
	offensive? ( games-misc/fortune-mod-slackware )
	games-misc/fortune-mod-smac
	games-misc/fortune-mod-sp-fortunes
	games-misc/fortune-mod-starwars
	games-misc/fortune-mod-strangelove
	games-misc/fortune-mod-tao
	games-misc/fortune-mod-thomas-ogrisegg
	games-misc/fortune-mod-zx-error"
