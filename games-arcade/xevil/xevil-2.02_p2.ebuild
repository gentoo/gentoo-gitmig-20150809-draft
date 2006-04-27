# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xevil/xevil-2.02_p2.ebuild,v 1.12 2006/04/27 21:50:15 tupone Exp $

inherit eutils games

DEB_PATCH=2
MY_PV=${PV/_p/r}
DESCRIPTION="3rd person, side-view, fast-action, kill-them-before-they-kill-you game"
HOMEPAGE="http://www.xevil.com/"
SRC_URI="http://www.xevil.com/download/stable/xevilsrc${MY_PV}.zip
	mirror://debian/pool/main/x/xevil/xevil_${MY_PV}-${DEB_PATCH}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="|| ( x11-libs/libXpm virtual/x11 )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	edos2unix readme.txt x11/*.{cpp,h} cmn/*.{cpp,h} makefile config.mk
	epatch ${WORKDIR}/xevil_${MY_PV}-${DEB_PATCH}.diff \
		"${FILESDIR}/${P}"-gcc41.patch
	sed -i \
		-e 's:-static::' \
		-e "s:CFLAGS=\":CFLAGS=\"${CFLAGS} :g" \
		-e 's:-lXpm:-lXpm -lpthread:g' \
		config.mk
}

src_compile() {
	emake || die #emake dies horribly
}

src_install() {
	dogamesbin x11/REDHAT_LINUX/xevil
	newgamesbin x11/REDHAT_LINUX/serverping xevil-serverping
	dodoc readme.txt
	prepgamesdirs
}
