# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.1.4.ebuild,v 1.8 2004/01/13 16:51:45 agriffis Exp $
inherit kde-dist eutils

DESCRIPTION="KDE games (solitaire :-)"
IUSE=""
KEYWORDS="x86 ppc sparc hppa amd64 alpha"

#13 Jul 2003: drobbins: building kdegames-3.1.2 fails on dual Xeon; disabling parallel mode :/
MAKEOPTS="$MAKEOPTS -j1"

src_unpack() {
	kde_src_unpack
	#epatch ${FILESDIR}/${P}-gcc33.diff
}

src_compile() {
	if [ ${ARCH} == "alpha" ] ; then
		export DO_NOT_COMPILE="kmines" # still b0rken on alpha
	fi
	kde_src_compile myconf configure
	if [ ${ARCH} == "alpha" ] ; then
		# ksirtet dies without kmines' libkdehighscores, so we have to build it
		# manually if we want ksirtet. Which we do. Everyone loves tetris!
		# First, we build libkdegames, since libkdehighscores depends on it.
		cd ${S}/libkdegames
		emake || die "died trying to build libkdegames"
		cd ../kmines/generic
		emake || die "died trying to build kmines/generic/libkdehighscores.la"
	fi
	kde_src_compile make
}
