# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xevil/xevil-2.02_p2.ebuild,v 1.3 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games eutils

DEB_PATCH=2
MY_PV=${PV/_p/r}
DESCRIPTION="3rd person, side-view, fast-action, kill-them-before-they-kill-you game"
HOMEPAGE="http://www.xevil.com/"
SRC_URI="http://www.xevil.com/download/stable/xevilsrc${MY_PV}.zip
	ftp://ftp.debian.org/debian/pool/main/x/xevil/xevil_${MY_PV}-${DEB_PATCH}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	edos2unix readme.txt x11/*.{cpp,h} cmn/*.{cpp,h} makefile config.mk
	epatch ${WORKDIR}/xevil_${MY_PV}-${DEB_PATCH}.diff
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
