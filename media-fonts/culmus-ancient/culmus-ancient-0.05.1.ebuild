# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/culmus-ancient/culmus-ancient-0.05.1.ebuild,v 1.1 2009/03/01 09:35:55 pva Exp $

inherit font versionator

MY_P=AncientSemiticFonts-$(replace_version_separator 2 '-')

DESCRIPTION="Ancient Semitic Scripts"
HOMEPAGE="http://culmus.sourceforge.net/"
SRC_URI="!fontforge? ( mirror://sourceforge/culmus/${MY_P}.TTF.tgz )
	fontforge? ( mirror://sourceforge/culmus/${MY_P}.tgz )"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2 MIT"
IUSE="fontforge"

DEPEND="fontforge? ( media-gfx/fontforge )"
RDEPEND=""

FONT_SUFFIX="ttf"
DOCS="CHANGES README"

if use fontforge; then
	S=${WORKDIR}/${MY_P}
	FONT_S=${S}/src
else
	S=${WORKDIR}/${MY_P}.TTF
	FONT_S=${S}/fonts
fi

src_compile() {
	if use fontforge; then
		cd src
		export FONTFORGE_LANGUAGE=ff
		make clean
		make all || die "Failed to build fonts"
	fi
}

pkg_postinst() {
	elog "This font contains support for fontconfig, which may make"
	elog "it render more smoothly. To enable it, do:"
	elog "eselect fontconfig enable 65-culmus.conf"
}
