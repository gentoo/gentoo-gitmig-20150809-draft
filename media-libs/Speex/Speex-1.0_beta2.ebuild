# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/Speex/Speex-1.0_beta2.ebuild,v 1.1 2002/10/29 17:53:30 verwilst Exp $

DESCRIPTION="open-source, patent-free voice codec"
HOMEPAGE="http://www.speex.org/"
SRC_URI="http://www.speex.org/download/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="media-libs/libogg"

S="${WORKDIR}/${P/_/}"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

}
