# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vb2rip/vb2rip-1.4.ebuild,v 1.2 2005/07/25 19:16:38 dholm Exp $

inherit versionator

MY_PV=$(replace_version_separator '')

DESCRIPTION="Konami VB2 sound format ripping utility"
HOMEPAGE="http://www.neillcorlett.com/vb2rip"
SRC_URI="http://www.neillcorlett.com/vb2rip/${PN}${MY_PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip"

S=${WORKDIR}/src

src_compile() {
	emake || die
}

src_install() {
	dobin vb2rip
	dodoc ${WORKDIR}/games.txt ${WORKDIR}/vb2rip.txt
}
