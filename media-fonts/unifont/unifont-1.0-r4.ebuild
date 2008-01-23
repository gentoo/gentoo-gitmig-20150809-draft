# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/unifont/unifont-1.0-r4.ebuild,v 1.2 2008/01/23 18:35:44 armin76 Exp $

inherit font

DESCRIPTION="GNU Unifont - a Pan-Unicode X11 bitmap iso10646 font"
HOMEPAGE="http://czyborra.com/"
SRC_URI="mirror://debian/pool/main/u/unifont/${P/-/_}.orig.tar.gz
	mirror://debian/pool/main/u/unifont/${P/-/_}-4.diff.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ia64 ~ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"

DEPEND="x11-apps/bdftopcf"

S="${WORKDIR}/${PN}-dvdeug-${PV}"
FONT_S="${S}"
FONT_SUFFIX="pcf.gz"

# Only installs fonts
RESTRICT="strip binchecks"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${P/-/_}-4.diff"
}

src_compile() {
	emake || die
	emake -f Makefile.new || die
	gzip -9 unifont.pcf || die
}
