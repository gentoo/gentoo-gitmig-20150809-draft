# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/nuvox/nuvox-07.1.ebuild,v 1.2 2008/01/20 21:54:28 opfer Exp $

MY_P="nuvoX_${PV}"

DESCRIPTION="NuvoX SVG icon theme."
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=38467"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~amd64 ~x86"
SLOT="0"

RESTRICT="strip binchecks"

S="${WORKDIR}/${MY_P}"

DEPEND="media-gfx/imagemagick"
RDEPEND=""

src_unpack() {
	unpack ${A}

	sed -i \
		-e '/rm -fr/d' \
		-e '/tar cf/d' \
		"${S}/buildset"
}

src_compile() {
	./buildset || die "unable to build icon sets."
}

src_install() {
	dodoc nuvoX_0.7/readme.txt
	rm nuvoX_0.7/{readme,license}.txt

	insinto /usr/share/icons/${PN}
	doins -r nuvoX_0.7/*
}
