# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/zinf-themes/zinf-themes-0.0.1.ebuild,v 1.4 2004/09/17 17:56:04 humpback Exp $

RESTRICT="nomirror"
DESCRIPTION="Collection of ZINF themes"
HOMEPAGE="http://www.zinf.org"
THEME_URI="http://www.zinf.org/themes"
SRC_URI="${THEME_URI}/AquaX.fat
	${THEME_URI}/Aquatica.fat
	${THEME_URI}/FreeAmpClassic.fat
	${THEME_URI}/Office.fat
	${THEME_URI}/Title.fat
	${THEME_URI}/Visions.fat
	${THEME_URI}/Dan.fat
	${THEME_URI}/Tommy.fat
	${THEME_URI}/Speakers.fat
	${THEME_URI}/aqua.fat
	${THEME_URI}/Doom.fat
	${THEME_URI}/kdc-7021.fat
	${THEME_URI}/Sunset.fat
	${THEME_URI}/PrimaryColors.fat
	${THEME_URI}/po_v2.fat
	${THEME_URI}/Radio.fat
	${THEME_URI}/Spacy.fat
	${THEME_URI}/JGTheme.fat
	${THEME_URI}/woodamp.fat
	${THEME_URI}/matt4.fat
	${THEME_URI}/octopussy.fat
	${THEME_URI}/IndigoTitle.fat
	${THEME_URI}/srv.fat
	${THEME_URI}/Linha_verde.fat
	${THEME_URI}/slackamp.fat
	${THEME_URI}/darkTheme.fat
	${THEME_URI}/notanamp.fat
	${THEME_URI}/fishamp.fat
	${THEME_URI}/toolbar.fat
	${THEME_URI}/darkscape.fat
	${THEME_URI}/keuntje.fat
	${THEME_URI}/paneltheme.fat
	${THEME_URI}/freeamp_by_cory.fat
	${THEME_URI}/FreeAmp_readable_titlebar.fat
	${THEME_URI}/marnes.fat
	${THEME_URI}/sos.fat
	${THEME_URI}/Luna_Theme.fat
	${THEME_URI}/pdAmp8compr.fat
	${THEME_URI}/spacemonkey.fat
	${THEME_URI}/s1.fat
	${THEME_URI}/reasonable.fat
	${THEME_URI}/Platine__blue_.fat
	${THEME_URI}/Platine__grey_.fat"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86 ~amd64"

IUSE=""

RDEPEND="media-sound/zinf"

src_unpack() {
	cd ${WORKDIR}
	for file in ${A};
	do
		cp ${DISTDIR}/${file} .
	done
}

src_compile() {
	:;
}

src_install () {
	dodir /usr/share/zinf/themes
	insinto /usr/share/zinf/themes
	cd ${WORKDIR}
	doins *
}
