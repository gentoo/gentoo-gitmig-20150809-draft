# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debootstrap/debootstrap-1.0.28.ebuild,v 1.2 2011/03/22 20:30:32 jer Exp $

inherit eutils

DESCRIPTION="Debian/Ubuntu bootstrap scripts"
HOMEPAGE="http://packages.qa.debian.org/d/debootstrap.html"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz
	mirror://gentoo/devices.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="sys-devel/binutils
	net-misc/wget
	>=app-arch/dpkg-1.14.20"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${PN}_${PV}.tar.gz
	cp "${DISTDIR}"/devices.tar.gz "${S}"
}

src_compile() {
	return
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc TODO debian/changelog
	doman debootstrap.8
}

pkg_postinst() {
	elog "To check Release files against a keyring"
	elog " (--keyring=K), please install app-crypt/gnupg."
}
