# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gringotts/gringotts-1.2.3.ebuild,v 1.1 2003/01/14 07:38:33 leonardop Exp $

DESCRIPTION="Utility that allows you to jot down sensitive data"
SRC_URI="http://devel.pluto.linux.it/projects/Gringotts/current/${P}.tar.bz2"
HOMEPAGE="http://devel.pluto.linux.it/projects/Gringotts/"

IUSE="X"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-libs/libgringotts-1.1.1
	dev-libs/popt
	>=x11-libs/gtk+-2.0.6-r1
	sys-apps/textutils
	X? ( x11-base/xfree )"

src_compile() {
	local myconf=""

    use X && myconf="--with-x" || myconf="--without-x"

    econf ${myconf}

	emake || die "Compilation failed"
}
 
src_install() {
	einstall

	dodoc AUTHORS BUGS ChangeLog COPYING FAQ README TODO
}
