# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/katalog/katalog-0.4_pre1.ebuild,v 1.2 2006/09/29 13:01:18 deathwing00 Exp $

inherit kde

MY_P=${P/_pre1/-preview}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Integrated cataloger for KDE"
SRC_URI="http://salvaste.altervista.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://salvaste.altervista.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

DEPEND=">=dev-util/scons-0.96.1"

RDEPEND=">=dev-db/sqlite-3.1"

src_compile() {
	local myconf="kdeincludes=$(kde-config --prefix)/include prefix=${ROOT}/usr "
	use amd64 && myconf="${myconf} libsuffix=64"

	scons configure ${myconf} || die "configure failed"
	scons ${MAKEOPTS} || die "scons failed"
}

src_install() {
	scons install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}

pkg_postinst() {
	ewarn ""
	ewarn "WARNING: This package is only for testing purposes as it is known"
	ewarn "         to be broken. Use at your own discretion."
	ewarn ""
}

need-kde 3.4
need-qt 3.3

