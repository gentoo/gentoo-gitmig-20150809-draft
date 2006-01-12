# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/efont-unicode/efont-unicode-0.4.2-r1.ebuild,v 1.2 2006/01/12 03:45:16 robbat2 Exp $

inherit font font-ebdftopcf

IUSE=""

MY_P="${PN}-bdf-${PV}"

DESCRIPTION="The /efont/ Unicode Bitmap Fonts"
HOMEPAGE="http://openlab.jp/efont/unicode/"
SRC_URI="http://openlab.jp/efont/dist/unicode-bdf/${MY_P}.tar.bz2"

# naga10 has free-noncomm license
LICENSE="public-domain BAEKMUK X11 as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

S="${WORKDIR}/${MY_P}"
FONT_S=${S}
FONT_SUFFIX="pcf.gz"
DOCS="README* COPYRIGHT ChangeLog INSTALL"
