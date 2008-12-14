# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

DESCRIPTION="SLiM (Simple Login Manager) themes pack"
HOMEPAGE="http://slim.berlios.de"
SRC_URI="mirror://berlios/slim/slim-1.2.3-themepack1a.tar.gz
	mirror://berlios/slim/slim-gentoo-simple.tar.bz2
	mirror://berlios/slim/slim-archlinux.tar.gz
	mirror://berlios/slim/slim-debian-moreblue.tar.bz2
	mirror://berlios/slim/slim-fingerprint.tar.gz
	mirror://berlios/slim/slim-flat.tar.gz
	mirror://berlios/slim/slim-lunar-0.4.tar.bz2
	mirror://berlios/slim/slim-previous.tar.gz
	mirror://berlios/slim/slim-rainbow.tar.gz
	mirror://berlios/slim/slim-rear-window.tar.gz
	mirror://berlios/slim/slim-scotland-road.tar.gz
	mirror://berlios/slim/slim-subway.tar.gz
	mirror://berlios/slim/slim-wave.tar.gz
	mirror://berlios/slim/slim-zenwalk.tar.gz
	http://www.xfce-look.org/CONTENT/content-files/48605-xfce-g-box-slim-0.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-misc/slim"
DEPEND=""

RESTRICT="strip binchecks"

S="${WORKDIR}"

src_compile() {
	einfo "Nothing to compile, installing.."
}

src_install() {
	for i in slim-archlinux capernoited flower2 mindlock lotus-{sage,midnight} \
		Zenwalk	isolated subway xfce-g-box; do
			rm ${i}/README
	done

	rm parallel-dimensions/{LICENSE*,COPY*} debian-moreblue/COPY* \
		lotus-{sage,midnight}/{LICENSE*,COPY*} xfce-g-box/COPYRIGHT.panel

	local themesdir="/usr/share/slim/themes"
	dodir ${themesdir}
	cp -R . "${D}"/${themesdir}
}
