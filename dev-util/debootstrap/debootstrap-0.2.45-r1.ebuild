# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debootstrap/debootstrap-0.2.45-r1.ebuild,v 1.3 2006/08/12 18:44:10 weeve Exp $

MY_PV=${PV}-0.2
DESCRIPTION="Debian bootstrap scripts"
HOMEPAGE="http://packages.qa.debian.org/d/debootstrap.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
SRC_URI="mirror://debian/pool/main/d/debootstrap/debootstrap_${MY_PV}.tar.gz
	mirror://gentoo/devices.tar.gz"
DEPEND="sys-devel/binutils
	net-misc/wget
	app-arch/dpkg"
IUSE=""

src_unpack() {
	unpack debootstrap_${MY_PV}.tar.gz
	cp ${DISTDIR}/devices.tar.gz ${S}
}

src_compile() {
	sed -i -e "s/chown/#chown/" Makefile
	make pkgdetails debootstrap-arch
}

src_install() {
	make DESTDIR=${D} install
}
