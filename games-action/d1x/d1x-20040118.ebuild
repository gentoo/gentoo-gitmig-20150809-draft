# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/d1x/d1x-20040118.ebuild,v 1.10 2007/04/06 00:01:01 nyhm Exp $

inherit eutils games

DESCRIPTION="Descent 1 Source Project"
HOMEPAGE="http://d1x.warpcore.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2 mirror://gentoo/descent1.5-patch.tar.bz2"

LICENSE="Descent1 D1X"
SLOT="0"
KEYWORDS="x86"
IUSE="opengl"

RDEPEND="media-libs/libsdl
	opengl? (
		virtual/opengl
		media-libs/libpng
		sys-libs/zlib )"

DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.97"

S=${WORKDIR}/${PN}

src_unpack() {
	cdrom_get_cds descent
	unpack ${A}

	mkdir "${WORKDIR}/descent1-data" || die

	# Copy data files
	cd "${CDROM_ROOT}/descent" || die

	cp chaos.hog chaos.msn descent.b50 descent.dem descent.hog \
		descent.m50 descent.phx descent.pig descent2.adv descentg.ini \
		level18.dem miniboss.dem readme.txt descent.faq orderfrm.txt \
		devteam.pcx \
		"${WORKDIR}/descent1-data" || die

	# Apply 1.0 -> 1.5 patch
	cd "${WORKDIR}/descent1.5-patch" || die
	for x in *.patch; do
		if patch "${WORKDIR}/descent1-data/${x%%.patch}" < "${x}" &>/dev/null ; then
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

	sed -i \
		-e 's/make /$(MAKE) /' \
		makefile rules.mak default.mak \
		|| die "sed failed"

	binname="d1x143"
	if use opengl; then
		binname="d1x143_ogl"
	fi

	cat > "${T}"/d1x <<-EOS
	#!/bin/sh
	if [[ ! -e "\${HOME}/.d1x" ]] ; then
	  mkdir "\${HOME}/.d1x"
	  cp "${GAMES_DATADIR}/d1x/d1x.ini" "\${HOME}/.d1x/"
	fi

	cd "\${HOME}/.d1x/"
	exec "$(games_get_libdir)"/${PN}/${binname} -missiondir "${GAMES_DATADIR}/d1x" "\$@"
	EOS
}

src_compile() {
	emake dep || die
	emake -j1 || die
}

src_install() {
	# Install D1X documentation
	cd "${S}"
	dodoc d1x.faq d1x.txt d1x140.txt readme.d1x readme.org todo.txt \
		bugs.txt || die

	# Copy data files
	cd "${WORKDIR}/descent1-data" || die

	insinto "${GAMES_DATADIR}/d1x"
	doins chaos.hog chaos.msn descent.b50 descent.dem descent.hog \
		descent.m50 descent.phx descent.pig descent2.adv descentg.ini \
		level18.dem miniboss.dem || die

	# Install original documentation files
	dodoc "readme.txt" "descent.faq" "orderfrm.txt" "devteam.pcx"

	# Copy d1x.ini
	cd "${S}"
	insinto "${GAMES_DATADIR}/d1x"
	doins d1x.ini || die

	# Install the binary executable
	insinto "$(games_get_libdir)/${PN}"
	insopts -m0750
	doins "${binname}"

	dogamesbin "${T}/d1x" || die "dogamesbin failed"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "You may want to install the additional map package, which contains"
	elog "popular third-party multiplayer maps."
	echo
	elog "To do so, run: emerge games-fps/descent1-maps"
}
