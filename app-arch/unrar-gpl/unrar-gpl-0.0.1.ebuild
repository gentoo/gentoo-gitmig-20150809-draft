# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar-gpl/unrar-gpl-0.0.1.ebuild,v 1.4 2007/07/05 00:51:45 angelos Exp $

inherit eutils
DESCRIPTION="Free rar unpacker"
HOMEPAGE="http://home.gna.org/unrar/"
SRC_URI="http://download.gna.org/unrar/${P/-gpl}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
