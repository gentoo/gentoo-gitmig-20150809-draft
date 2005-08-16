# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gtranscode/gtranscode-0.3.ebuild,v 1.4 2005/08/16 02:07:31 weeve Exp $

inherit eutils
DESCRIPTION="A GTK2 frontend for transcode."
HOMEPAGE="http://www.fuzzymonkey.org/newfuzzy/software/gtranscode/"
SRC_URI="http://www.fuzzymonkey.org/files/${PN}-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4.9
>=media-video/transcode-0.6.11"

S=${WORKDIR}/${PN}

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe ${S}/gtranscode
}
