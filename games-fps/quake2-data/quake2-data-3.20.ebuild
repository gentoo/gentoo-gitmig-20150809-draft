# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake2-data/quake2-data-3.20.ebuild,v 1.4 2003/11/30 06:04:14 vapier Exp $

inherit games

DESCRIPTION="iD Software's Quake 2 ... the data files"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/quake2/q2-${PV}-x86-full-ctf.exe"

LICENSE="Q2EULA"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="videos"

DEPEND="app-arch/unzip
	virtual/x11"

S=${WORKDIR}

src_unpack() {
	unzip -L -q ${DISTDIR}/q2-${PV}-x86-full-ctf.exe
}

src_install() {
	games_get_cd Install
	games_verify_cd Quake 2
	if [ -e ${GAMES_CD}/Install/Data ] ; then
		GAMES_CD=${GAMES_CD}/Install/Data
		einfo "Source is the CD"
	elif [ -e ${GAMES_CD}/baseq2 ] ; then
		GAMES_CD=${GAMES_CD}
		einfo "Source is an installed copy"
	else
		die "Could not determine what ${GAMES_CD} points at"
	fi

	dodoc DOCS/* 3.20_Changes.txt
	newdoc ctf/readme.txt ctf-readme.txt
	dohtml -r ${GAMES_CD}/DOCS/quake2_manual/*

	dodir ${GAMES_DATADIR}/${PN}/baseq2

	if [ `use videos` ] ; then
		insinto ${GAMES_DATADIR}/${PN}/baseq2/video
		doins ${GAMES_CD}/baseq2/video/*
	fi

	insinto ${GAMES_DATADIR}/${PN}/baseq2
	doins ${GAMES_CD}/baseq2/pak0.pak || die "couldnt grab pak0.pak"
	doins baseq2/*.pak || die "couldnt grab release paks"
	doins baseq2/maps.lst || die "couldnt grab maps.lst"
	cp -R baseq2/players ${D}/${GAMES_DATADIR}/${PN}/baseq2/ || die "couldnt grab player models"

	insinto ${GAMES_DATADIR}/${PN}/ctf
	doins ctf/*.{cfg,ico,pak} || die "couldnt grab ctf"

	# install symlinks for all the packages that may utilize this ebuild
	if has_version games-fps/quake2-icculus ; then
		einfo "Creating symlinks for quake2-icculus"
		for qdir in "" -qmax ; do
			basedir=${GAMES_LIBDIR}/quake2-icculus${qdir}/baseq2
			ctfdir=${GAMES_LIBDIR}/quake2-icculus${qdir}/ctf
			dodir ${basedir}
			for f in pak{0,1,2}.pak players ; do
				[ -e ${basedir}/${f} ] && continue
				dosym ${GAMES_DATADIR}/${PN}/baseq2/${f} ${basedir}/${f}
			done
			dodir ${ctfdir}
			[ -e ${ctfdir}/pak0.pak ] || \
			dosym ${GAMES_DATADIR}/${PN}/ctf/pak0.pak ${ctfdir}/pak0.pak
		done
	fi

	prepgamesdirs
}
