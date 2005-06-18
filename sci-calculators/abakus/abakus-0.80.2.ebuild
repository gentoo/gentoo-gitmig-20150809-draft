# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/abakus/abakus-0.80.2.ebuild,v 1.1 2005/06/18 08:07:15 centic Exp $

inherit kde

DESCRIPTION="Abakus is a simple calculator for kde, similar to bc with a nice gui."
HOMEPAGE="http://grammarian.homelinux.net/abakus/"
SRC_URI="http://grammarian.homelinux.net/abakus/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-util/scons-0.96.1"
#RDEPEND=""

need-kde 3.3

src_compile() {
	local myconf="kdeincludes=$(kde-config --prefix)/include prefix=/usr"
	use amd64 && myconf="${myconf} libsuffix=64"
	scons configure ${myconf} || die "configure failed"
	scons ${MAKEOPTS} || die "scons failed"
}

src_install() {
	DESTDIR="${D}" scons install
	dodoc AUTHORS COPYING README
}
