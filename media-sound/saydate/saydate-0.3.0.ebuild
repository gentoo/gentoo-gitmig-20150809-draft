# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/saydate/saydate-0.3.0.ebuild,v 1.12 2004/10/19 03:12:43 tgall Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A Linux shell program that talks the date and system uptime."
HOMEPAGE="http://unihedron.com/projects/saydate/saydate.php"
SRC_URI="http://unihedron.com/projects/saydate/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 sparc amd64 ppc64"

DEPEND="=sys-apps/sed-4*"
IUSE=""

src_compile() {
	einfo 'Nothing to compile'
}

src_install () {
	insinto /usr/share/man/man1
	doins ${S}/man/saydate.1.gz ${S}/man/au2raw.1.gz

	dodir /usr/share/saydate
	insinto /usr/share/saydate
	doins ${S}/data/*.raw

	sed -i "s:/dev/audio:/dev/dsp:" ${S}/saydate
	sed -i "s:/dev/audio:/dev/dsp:" ${S}/au2raw
	sed -i "s:/dev/audio:/dev/dsp:" ${S}/DESIGN
	dodoc README TODO HISTORY DESIGN COPYING
	dobin saydate au2raw
}
