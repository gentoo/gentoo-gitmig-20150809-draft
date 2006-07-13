# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/dynamite/dynamite-0.1.ebuild,v 1.9 2006/07/13 20:53:39 liquidx Exp $

inherit eutils

DESCRIPTION="Dynamite is a tool and library for decompressing data compressed with PKWARE Data Compression Library"
HOMEPAGE="http://synce.sourceforge.net/synce/dynamite.php"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-segv.patch

}
src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
