# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lfpfonts-var/lfpfonts-var-0.83-r2.ebuild,v 1.4 2004/08/17 21:27:46 agriffis Exp $

inherit font

DESCRIPTION="Linux Font Project variable-width fonts"
HOMEPAGE="http://sourceforge.net/projects/xfonts/"
SRC_URI="mirror://sourceforge/xfonts/${P}.tar.bz2"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="x86 sparc ppc alpha amd64"
IUSE=""

S=${WORKDIR}/${PN}

FONT_SUFFIX="pcf.gz"

FONT_S=${S}/lfp-var

DOCS="doc/*"
