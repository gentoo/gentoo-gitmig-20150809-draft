# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debootstrap/debootstrap-0.3.3.2.ebuild,v 1.6 2007/08/15 20:08:52 gustavoz Exp $

DESCRIPTION="Debian bootstrap scripts"
HOMEPAGE="http://packages.qa.debian.org/d/debootstrap.html"
SRC_URI="mirror://debian/pool/main/d/debootstrap/debootstrap_${PV}.tar.gz
	mirror://gentoo/devices.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE="nodpkg"

DEPEND="sys-devel/binutils
	net-misc/wget
	!nodpkg? ( app-arch/dpkg )"

src_unpack() {
	unpack debootstrap_${PV}.tar.gz
	cp "${DISTDIR}"/devices.tar.gz "${S}"/devices-std.tar.gz || die
}

src_compile() {
	emake pkgdetails debootstrap-arch || die
}

src_install() {
	make DESTDIR="${D}" install-allarch || die
	dodoc TODO
}
