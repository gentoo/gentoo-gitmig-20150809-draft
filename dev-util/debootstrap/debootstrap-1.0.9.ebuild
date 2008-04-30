# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debootstrap/debootstrap-1.0.9.ebuild,v 1.1 2008/04/30 14:38:32 armin76 Exp $

inherit eutils

DESCRIPTION="Debian/Ubuntu bootstrap scripts"
HOMEPAGE="http://packages.qa.debian.org/d/debootstrap.html"
SRC_URI="mirror://debian/pool/main/d/debootstrap/debootstrap_${PV}.tar.gz mirror://gentoo/devices.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-devel/binutils
	net-misc/wget
	app-arch/dpkg"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack debootstrap_${PV}.tar.gz
	cp "${DISTDIR}"/devices.tar.gz "${S}"
}

src_compile() {
	return
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc TODO
}
