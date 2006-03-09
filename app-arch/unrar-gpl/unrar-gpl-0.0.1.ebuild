# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar-gpl/unrar-gpl-0.0.1.ebuild,v 1.3 2006/03/09 13:48:33 hanno Exp $

inherit eutils
DESCRIPTION="Free rar unpacker"
HOMEPAGE="http://home.gna.org/unrar/"
SRC_URI="http://download.gna.org/unrar/${P/-gpl}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="!app-arch/unrar"
S=${WORKDIR}/${P/-gpl}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS README INSTALL todo
}
