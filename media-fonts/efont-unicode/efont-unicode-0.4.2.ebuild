# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/efont-unicode/efont-unicode-0.4.2.ebuild,v 1.3 2004/11/06 14:56:30 pylon Exp $

inherit font

IUSE=""

MY_P="${PN}-bdf-${PV}"

DESCRIPTION="The /efont/ Unicode Bitmap Fonts"
HOMEPAGE="http://openlab.jp/efont/unicode/"
SRC_URI="http://openlab.jp/efont/dist/unicode-bdf/${MY_P}.tar.bz2"

# naga10 has free-noncomm license
LICENSE="public-domain BAEKMUK X11 as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ppc ~amd64 ~ppc64"

DEPEND="virtual/x11"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
FONT_S=${S}
FONT_SUFFIX="pcf.gz"
DOCS="README* COPYRIGHT ChangeLog INSTALL"

src_compile () {

	for i in *.bdf ; do
		echo "Converting $i into ${i/bdf/pcf} ..."
		/usr/X11R6/bin/bdftopcf -o ${i/bdf/pcf} ${i} || die
		echo "Compressing ${i/bdf/pcf} ..."
		gzip -9 ${i/bdf/pcf} || die
	done
}
