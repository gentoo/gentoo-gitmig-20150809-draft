# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/pigiarniq/pigiarniq-1.ebuild,v 1.1 2008/04/13 00:20:27 yngwin Exp $

inherit font

DESCRIPTION="Nunavut's official Inuktitut font"
HOMEPAGE="http://www.gov.nu.ca/english/font/"
SRC_URI="http://www.gov.nu.ca/documents/fonts/pigiarniq.zip"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-arch/unzip"
RDEPEND=""
S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf"
