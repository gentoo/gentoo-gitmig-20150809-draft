# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/katalog/katalog-0.4.ebuild,v 1.6 2009/02/22 15:30:01 armin76 Exp $

inherit kde

DESCRIPTION="Integrated cataloger for KDE"
SRC_URI="http://salvaste.altervista.org/files/${P}.tar.gz"
HOMEPAGE="http://salvaste.altervista.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc sparc x86"
IUSE=""

DEPEND=">=dev-util/scons-0.96.1"

RDEPEND=">=dev-db/sqlite-3.1"

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

src_compile() {
	local myconf="kdeincludes=$(kde-config --prefix)/include prefix=/usr "
	use amd64 && myconf="${myconf} libsuffix=64"

	scons configure ${myconf} || die "configure failed"
	scons ${MAKEOPTS} || die "scons failed"
}

src_install() {
	scons install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}

need-kde 3.4
