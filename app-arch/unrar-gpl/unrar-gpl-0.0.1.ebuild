# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar-gpl/unrar-gpl-0.0.1.ebuild,v 1.1 2004/12/13 12:09:22 hanno Exp $

inherit eutils
DESCRIPTION="Free rar unpacker"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/u/unrar/"
SRC_URI="mirror://debian/pool/main/u/unrar/unrar_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="!app-arch/unrar"
S=${WORKDIR}/unrar-${PV}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS README INSTALL todo
}
