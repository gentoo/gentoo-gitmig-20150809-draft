# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkexif/libkexif-0.2.5-r1.ebuild,v 1.1 2009/02/09 00:21:16 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A KDE library for loss-less EXIF operations."
HOMEPAGE="http://www.kipi-plugins.org/"
SRC_URI="mirror://sourceforge/kipi/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=media-libs/libexif-0.6.9"
RDEPEND="${DEPEND}"

LANGS="ar bg br ca cs cy da de el en_GB es et fr ga gl is it ja lt mt nb nl nn
pa pl pt pt_BR ru rw sk sr sr@Latn sv ta tr uk zh_CN"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	kde_src_unpack
	cd "${WORKDIR}/${P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} || rm -rf "${X}"
	done
	rm -f "${S}/configure"
}

need-kde 3.5
