# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent3/descent3-1.4.0b-r1.ebuild,v 1.2 2006/01/10 20:08:05 wolf31o2 Exp $

inherit eutils games

IUSE="nocd videos"
DESCRIPTION="Descent 3 - 3-Dimensional indoor/outdoor spaceship combat"
HOMEPAGE="http://www.lokigames.com/products/descent3/"
SRC_URI="mirror://lokigames/${PN}/${PN}-1.4.0a-x86.run
	mirror://lokigames/${PN}/${P}-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="~amd64 x86"
RESTRICT="nostrip"

DEPEND=""
RDEPEND="virtual/opengl
	x86? (
		|| (
			(
				x11-libs/libX11
				x11-libs/libXext )
			virtual/x11 ) )
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl
		>=sys-libs/lib-compat-loki-0.2 )"

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	if use videos ; then
		ewarn "The installed game takes about 1.2GB of space!"
		cdrom_get_cds missions/d3.mn3 movies/level1.mve
	else
		cdrom_get_cds missions/d3.mn3
	fi
	if use nocd ; then
		ewarn "The installed game takes about 510MB of space!"
	else
		ewarn "The installed game takes about 220MB of space!"
	fi
	games_pkg_setup
}

src_unpack() {
	mkdir -p ${S}/{a,b}
	cd ${S}/a
	unpack_makeself ${PN}-1.4.0a-x86.run
	cd ${S}/b
	unpack_makeself ${P}-x86.run
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto ${dir}
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/{${PN},nettest} \
		|| die "copying executables"
	insinto ${dir}
	doins ${CDROM_ROOT}/{FAQ.txt,README{,.mercenary},d3.hog,icon.{bmp,xpm}} \
		|| die "copying files"

	cd ${Ddir}
	tar xzf ${CDROM_ROOT}/data.tar.gz || die "uncompressing data"
	tar xzf ${CDROM_ROOT}/shared.tar.gz || die "uncompressing shared"

	if use nocd; then
		doins -r ${CDROM_ROOT}/missions || die "copying missions"
	fi

	if use videos ; then
		cdrom_load_next_cd
		doins -r ${CDROM_ROOT}/movies || die "copying movies"
	fi

	cd ${S}/a
	bin/Linux/x86/loki_patch --verify patch.dat
	bin/Linux/x86/loki_patch patch.dat ${Ddir} >& /dev/null || die "patching a"
	cd ${S}/b
	bin/Linux/x86/loki_patch --verify patch.dat
	bin/Linux/x86/loki_patch patch.dat ${Ddir} >& /dev/null || die "patching b"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \

	if use amd64
	then
		dosym /usr/$(get_libdir)/loki_libsmpeg-0.4.so.0 \
		${dir}/libsmpeg-0.4.so.0 || die "failed compatibility symlink"
	fi

	games_make_wrapper descent3 ./descent3.dynamic "${dir}" "${dir}"
	newicon ${CDROM_ROOT}/icon.xpm ${PN}.xpm

	# Fix for 2.6 kernel crash
	cd ${Ddir}
	ln -sf ppics.hog PPics.Hog

	prepgamesdirs
	make_desktop_entry ${PN} "Descent 3" ${PN}
}

pkg_postinst() {
	games_pkg_postinst
	einfo "To play the game run:"
	einfo " descent3"
	echo
}
