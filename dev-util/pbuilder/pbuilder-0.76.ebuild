# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pbuilder/pbuilder-0.76.ebuild,v 1.2 2003/07/29 13:59:12 lanius Exp $

DESCRIPTION="personal package builder for Debian packages"
HOMEPAGE="http://packages.qa.debian.org/p/pbuilder.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
SRC_URI="http://http.us.debian.org/debian/pool/main/p/pbuilder/pbuilder_${PV}.tar.gz"
S=${WORKDIR}/pbuilder
DEPEND=">=sys-apps/debianutils-1.13.1
	net-misc/wget
	dev-util/debootstrap
	app-arch/dpkg"
IUSE=""

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS COPYING ChangeLog README THANKS
}
