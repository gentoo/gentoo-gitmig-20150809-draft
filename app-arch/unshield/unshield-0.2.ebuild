# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unshield/unshield-0.2.ebuild,v 1.6 2005/01/01 12:01:02 eradicator Exp $

DESCRIPTION="InstallShield CAB file extractor."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=sys-libs/zlib-1.1.4"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
