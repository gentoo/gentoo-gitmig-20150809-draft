# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.1.2.ebuild,v 1.3 2003/06/10 23:38:27 wwoods Exp $
inherit kde-dist eutils

DESCRIPTION="KDE games (solitaire :-)"
IUSE=""
KEYWORDS="x86 ~ppc sparc ~alpha"

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
