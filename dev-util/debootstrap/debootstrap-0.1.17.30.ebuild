# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debootstrap/debootstrap-0.1.17.30.ebuild,v 1.3 2004/01/23 18:28:52 lanius Exp $

DESCRIPTION="Debian bootstrap scripts"
HOMEPAGE="http://packages.qa.debian.org/d/debootstrap.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
SRC_URI="mirror://debian/pool/main/d/debootstrap/debootstrap_${PV}.tar.gz"
DEPEND="sys-devel/binutils
	net-misc/wget"
IUSE=""

src_compile() {
	make
}

src_install() {
	make DESTDIR=${D} install
}
