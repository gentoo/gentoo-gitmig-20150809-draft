# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gavl/gavl-0.2.7.ebuild,v 1.1 2008/01/21 20:44:35 drac Exp $

DESCRIPTION="library for handling uncompressed audio and video data"
HOMEPAGE="http://gmerlin.sourceforge.net"
SRC_URI="mirror://sourceforge/gmerlin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND=""

src_unpack() {
	unpack ${A}
	sed -i -e 's:-O3 -funroll-all-loops -fomit-frame-pointer -ffast-math::' \
		"${S}"/configure || die "sed failed."
}

src_compile() {
	econf --without-cpuflags --docdir=/usr/share/doc/${PF}/html
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README TODO
}
