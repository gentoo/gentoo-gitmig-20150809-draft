# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent2-data/descent2-data-1.0.ebuild,v 1.1 2007/01/09 21:28:10 wolf31o2 Exp $

inherit eutils games

MY_PV=${PV/./}
SOW="descent2.sow"

DESCRIPTION="Data files for Descent 2"
HOMEPAGE="http://www.interplay.com/games/product.asp?GameID=109"
SRC_URI=""
# Don't have a method of applying the ver 1.2 patch in Linux
# ftp://ftp.interplay.com/pub/patches/d2ptch${MY_PV}.exe
# mirror://3dgamers/descent2/d2ptch${MY_PV}.exe

# See readme.txt
LICENSE="${PN}"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

# d2x-0.2.5-r2 may include the CD data itself.
# d2x-0.2.5-r3 does not include the CD data.
# d2x-rebirth is favoured because it is stable.
RDEPEND="|| (
	games-action/d2x-rebirth
	games-action/d2x-xl
	>=games-action/d2x-0.2.5-r3 )"
DEPEND="!<games-action/d2x-0.2.5-r3
	app-arch/unarj"

S=${WORKDIR}
dir=${GAMES_DATADIR}/d2x

pkg_setup() {
	games_pkg_setup

	# Could have the $SOW file in $FILESDIR, in a local overlay
	if [[ -e "${FILESDIR}/${SOW}" ]] ; then
		einfo "Using ${SOW} from ${FILESDIR}"
	else
		cdrom_get_cds d2data
		if [[ -e "${CDROM_ROOT}/d2data/${SOW}" ]] ; then
			einfo "Found the original Descent 2 CD."
		else
			die "You need the original Descent 2 CD"
		fi
	fi
}

src_unpack() {
	local f="${FILESDIR}/${SOW}"
	[[ -e "${f}" ]] || f="${CDROM_ROOT}/d2data/${SOW}"
	unarj e "${f}" || die "unarj ${f} failed"

	rm endnote.txt
	mkdir doc
	mv *.txt doc

	# Remove files not needed by any Linux native client
	rm *.{bat,dll,exe,ini,lst}
}

src_install() {
	insinto "${dir}"
	doins * || die "doins * failed"

	dodoc doc/*

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "A client is needed to run the game, e.g. games-action/d2x-rebirth."
	echo
}
