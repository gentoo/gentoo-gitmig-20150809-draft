# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-3.1.2.ebuild,v 1.2 2003/05/20 23:25:29 weeve Exp $
inherit kde-dist eutils

DESCRIPTION="KDE games (solitaire :-)"
IUSE=""
KEYWORDS="x86 ~ppc sparc ~alpha"

src_unpack() {
    kde_src_unpack
    if [ ${ARCH} == "alpha" ] ; then
	einfo "Not building kmines due to linking problems on alpha"
	cd ${S}
	cp subdirs subdirs.orig
	grep -v kmines subdirs.orig > subdirs
    fi
}

src_compile() {
    kde_src_compile myconf configure
    if [ ${ARCH} == "alpha" ] ; then
	# ksirtet dies without kmines' libkdehighscores, so we have to build it
	# manually if we want ksirtet. Which we do. Everyone loves tetris!
	# But first, build libkdegames, since libkdehighscores depends on it.
	cd ${S}/libkdegames
	emake || die "died trying to build libkdegames"
	cd ../kmines/generic
	emake || die "died trying to build kmines/generic/libkdehighscores.la"
    fi
    kde_src_compile make
}
