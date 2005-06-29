# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/d2x/d2x-0.2.5-r1.ebuild,v 1.7 2005/06/29 00:32:25 vapier Exp $

inherit flag-o-matic eutils games

DATAFILE="d2shar10"
DESCRIPTION="Descent 2"
HOMEPAGE="http://icculus.org/d2x/"
SRC_URI="http://icculus.org/d2x/src/${P}.tar.gz
	!nocd? ( http://icculus.org/d2x/data/${DATAFILE}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="nocd debug opengl ggi svga"

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	nocd? ( app-arch/unarj )
	opengl? ( virtual/opengl )
	ggi? ( media-libs/libggi )
	svga? ( media-libs/svgalib )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

pkg_setup() {
	games_pkg_setup

	if use nocd ; then
		if [[ ! -e ${DISTDIR}/descent2.sow ]] ; then
			cdrom_get_cds d2data
			if [ -e ${CDROM_ROOT}/d2data/descent2.sow ] ; then
				export CDROM_ROOT=${CDROM_ROOT}/d2data
				einfo "Found the original Descent2 CD"
				einfo "Copying descent2.sow to ${DISTDIR}"
				cp ${CDROM_ROOT}/descent2.sow ${DISTDIR}/descent2.sow
			else
				die "You need the original Descent2 CD"
			fi
		fi
	fi
}

src_unpack() {
	unpack ${A}
	if use nocd ; then
		cd ${WORKDIR}
		mkdir SOW
		cd SOW
		unarj e ${DISTDIR}/descent2.sow
	fi
	rm *.{exe,bat}
	cd ${S}
	epatch ${FILESDIR}/${PV}-shellscripts.patch
}

src_compile() {
	# --disable-network --enable-console
	local myconf="$(use_enable x86 assembler)"
	use debug \
		&& myconf="${myconf} --enable-debug --disable-release" \
		|| myconf="${myconf} --disable-debug --enable-release"
	# we do this because each of the optional guys define the same functions
	# in gr, thus when they go to link they cause redefine errors ...
	# we build each by it self, save the binary file, clean up, and start over
	mkdir my-bins
	for ren in sdl $(useq opengl && echo opengl) \
			$(useq svga && echo svga) $(useq ggi && echo ggi)
	do
		[ "${ren}" == "sdl" ] \
			&& renconf="" \
			|| renconf="--with-${ren}"
		[ "${ren}" == "svga" ] \
			&& defflags="-DSVGALIB_INPUT" \
			|| defflags=""
		make distclean
		egamesconf \
			${myconf} \
			${renconf} \
			--datadir=${GAMES_DATADIR_BASE} \
			|| die "conf ${ren}"
		emake CXXFLAGS="${CXXFLAGS} ${defflags}" || die "build ${ren}"
		mv d2x* my-bins/
	done
}

src_install() {
	make install DESTDIR=${D} || die
	dogamesbin my-bins/*
	dodir ${GAMES_DATADIR}/${PN}
	if use nocd ; then
		cp -r ${WORKDIR}/SOW/* ${D}/${GAMES_DATADIR}/${PN}/
	else
		cp -r ${WORKDIR}/${DATAFILE}/* ${D}/${GAMES_DATADIR}/${PN}/
	fi
	dodoc AUTHORS ChangeLog NEWS README* TODO readme.txt
	prepgamesdirs
}
