# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.1.3.ebuild,v 1.7 2003/09/11 01:16:25 msterret Exp $
inherit kde-dist eutils

DESCRIPTION="KDE games (solitaire :-)"
IUSE=""
KEYWORDS="x86 ~ppc ~sparc"

#13 Jul 2003: drobbins: building kdegames-3.1.2 fails on dual Xeon; disabling parallel mode :/
MAKEOPTS="$MAKEOPTS -j1"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/${P}-gcc33.diff
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
