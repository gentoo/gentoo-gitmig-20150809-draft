# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/d1x/d1x-20040118.ebuild,v 1.3 2004/02/08 21:30:56 vapier Exp $

inherit games eutils

DESCRIPTION="Descent 1 Source Project"
HOMEPAGE="http://d1x.warpcore.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2 mirror://gentoo/descent1.5-patch.tar.bz2"

LICENSE="Descent1 D1X"
SLOT="0"
KEYWORDS="x86"
IUSE="opengl"

DEPEND=">=dev-lang/nasm-0.97
	media-libs/libsdl
	opengl? (
		virtual/opengl
		media-libs/libpng
		sys-libs/zlib
	)"

S=${WORKDIR}/${PN}

pkg_setup () {
	cdrom_get_cds descent
	games_pkg_setup
}

src_unpack () {
	unpack ${A}

	local dir="${WORKDIR}/descent1-data"
	mkdir "${dir}" || die

	# Copy data files
	local src="${CDROM_ROOT}/descent"
	cd "${src}" || die

	for x in chaos.hog chaos.msn descent.b50 descent.dem descent.hog \
		descent.m50 descent.phx descent.pig descent2.adv descentg.ini \
		level18.dem miniboss.dem readme.txt descent.faq orderfrm.txt \
		devteam.pcx; do
	  cp "${x}" "${dir}" || die
	done

	# Apply 1.0 -> 1.5 patch
	cd "${WORKDIR}/descent1.5-patch" || die
	for x in *.patch; do
		if patch "${dir}/${x%%.patch}" < "${x}" \
			>/dev/null 2>/dev/null; then
			einfo "Patched ${x%%.patch} to version 1.5"
		fi
	done

	cd "${S}" || die
	epatch "${FILESDIR}/d1x-missiondir.patch" || die

	cp defines.in defines.mak || die
	epatch "${FILESDIR}/d1x-makefile-linux.patch" || die

	if use opengl; then
		sed -i -e 's/^#\(SDLGL_IO = 1\)/\1/' defines.mak || die
	else
		sed -i -e 's/^#\(SDL_IO = 1\)/\1/' defines.mak || die
	fi
}

src_compile () {
	make dep || die
	make || die
}

src_install() {
	# Install D1X documentation
	cd "${S}"
	dodoc d1x.faq d1x.txt d1x140.txt readme.d1x readme.org todo.txt \
		bugs.txt || die
	dodir

	# Copy data files
	local src="${WORKDIR}/descent1-data"
	local dir="${GAMES_DATADIR}/d1x"
	cd "${src}" || die

	dodir "${dir}"

	insinto "${dir}"
	for x in chaos.hog chaos.msn descent.b50 descent.dem descent.hog \
		descent.m50 descent.phx descent.pig descent2.adv descentg.ini \
		level18.dem miniboss.dem; do
	  doins "${x}" || die
	done

	# Install original documentation files
	dodoc "readme.txt" "descent.faq" "orderfrm.txt" "devteam.pcx" || die

	# Copy d1x.ini
	cd "${S}" || die
	insinto "${dir}"
	doins d1x.ini || die

	# Install the binary executable
	local binname
	if use opengl; then
		binname="d1x143_ogl"
	else
		binname="d1x143"
	fi

	insinto "${GAMES_LIBDIR}/${PN}"
	insopts -m0750
	doins "${binname}"

	# Install the shell script wrapper
	local tempbin
	tempbin="${T}/d1x"
	echo -en "#!/bin/sh\n" > "${tempbin}"
	echo -en "if [ ! -e \"\${HOME}/.d1x\" ]; then\n" >> "${tempbin}"
	echo -en "  mkdir \"\${HOME}/.d1x\"\n" >> "${tempbin}"
	echo -en "  cp \"${dir}/d1x.ini\" \"\${HOME}/.d1x/\"\n" >> "${tempbin}"
	echo -en "fi\n\n" >> "${tempbin}"
	echo -en "cd \"\${HOME}/.d1x/\"\n" >> "${tempbin}"
	echo -en "exec ${GAMES_LIBDIR}/${PN}/${binname} " >> "${tempbin}"
	echo -en "-missiondir \"${dir}\" \"\$@\"\n" >> "${tempbin}"
	dogamesbin "${tempbin}"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "You may want to install the additional map package, which contains"
	einfo "popular third-party multiplayer maps."
	echo
	einfo "To do so, run: emerge games-fps/descent1-maps"
}
