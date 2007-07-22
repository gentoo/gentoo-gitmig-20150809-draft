# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/unifont/unifont-1.0-r3.ebuild,v 1.12 2007/07/22 07:33:43 dirtyepic Exp $

inherit eutils

IUSE="X"

DESCRIPTION="X11 GNU unicode font"
HOMEPAGE="http://czyborra.com/"
SRC_URI="mirror://debian/pool/main/u/unifont/${P/-/_}.orig.tar.gz
	mirror://debian/pool/main/u/unifont/${P/-/_}-1.diff.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

DEPEND="x11-apps/bdftopcf
		x11-apps/mkfontdir"
RDEPEND=""

FONTPATH="/usr/share/fonts/${PN}"
S="${WORKDIR}/${PN}-dvdeug-${PV}"

# Only installs fonts
RESTRICT="strip binchecks"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${P/-/_}-1.diff"
}

src_compile() {
	emake || die
	emake -f Makefile.new || die
}

src_install() {
	insinto ${FONTPATH}
	doins unifont*.gz
	use X && mkfontdir "${D}${FONTPATH}"
}
