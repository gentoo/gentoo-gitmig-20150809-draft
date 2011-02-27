# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/dynamite/dynamite-0.1.1.ebuild,v 1.4 2011/02/27 10:39:34 ssuominen Exp $

EAPI=2

DESCRIPTION="A tool (and library) for decompressing data compressed with PKWARE Data Compression Library"
HOMEPAGE="http://synce.sourceforge.net/synce/dynamite.php"
SRC_URI="mirror://sourceforge/synce/lib${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static-libs"

S=${WORKDIR}/lib${P}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die

	find "${D}" -name '*.la' -exec rm -f {} +
}
