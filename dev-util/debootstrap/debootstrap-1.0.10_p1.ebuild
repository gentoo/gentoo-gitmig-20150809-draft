# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debootstrap/debootstrap-1.0.10_p1.ebuild,v 1.1 2009/02/04 18:40:01 jer Exp $

inherit eutils

MY_PV="${PV/_p1/lenny1}"

DESCRIPTION="Debian/Ubuntu bootstrap scripts"
HOMEPAGE="http://packages.qa.debian.org/d/debootstrap.html"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${MY_PV}.tar.gz
	mirror://gentoo/devices.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-devel/binutils
	net-misc/wget
	>=app-arch/dpkg-1.14.20"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack "${PN}_${MY_PV}.tar.gz"
	cp "${DISTDIR}"/devices.tar.gz "${S}"
}

src_compile() {
	return
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc TODO
}
