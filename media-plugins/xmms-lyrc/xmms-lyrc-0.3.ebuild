# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-lyrc/xmms-lyrc-0.3.ebuild,v 1.4 2004/09/03 08:12:55 eradicator Exp $

IUSE=""

inherit eutils

MY_PN=${PN/xmms-/}
MY_P=${P/xmms-/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="An XMMS plugin for displaying lyrics"
HOMEPAGE="http://www.sourceforge.net/projects/lyrc"
SRC_URI="mirror://sourceforge/lyrc/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 sparc ~ppc"

DEPEND="media-sound/xmms
	dev-lang/python
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch
}

src_compile() {
	emake
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README Changelog
}
