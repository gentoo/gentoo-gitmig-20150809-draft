# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lfpfonts-var/lfpfonts-var-0.83-r1.ebuild,v 1.3 2004/07/14 17:06:40 agriffis Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Linux Font Project variable-width fonts"
HOMEPAGE="http://sourceforge.net/projects/xfonts/"
SRC_URI="mirror://sourceforge/xfonts/${P}.tar.bz2"
RESTRICT="nomirror"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64"
IUSE=""

DEPEND="virtual/x11"
RDEPEND=""

src_install() {
	dodoc doc/*
	cd lfp-var
	insinto /usr/share/fonts/lfp-var
	insopts -m0644
	doins *
}
