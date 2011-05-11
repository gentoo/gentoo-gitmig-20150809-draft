# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cdebootstrap/cdebootstrap-0.5.7.ebuild,v 1.3 2011/05/11 11:33:42 tomka Exp $

EAPI=2

DESCRIPTION="Debian/Ubuntu bootstrap scripts written in C"
HOMEPAGE="http://packages.qa.debian.org/c/cdebootstrap.html"
SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${PV}.tar.gz
	mirror://debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2009.01.31.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/dpkg
	dev-libs/libdebian-installer"
RDEPEND="app-crypt/gnupg
	net-misc/wget"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/* debian/changelog debian/NEWS || die

	# Install the keyrings
	cd "${WORKDIR}"
	insinto /usr/share/keyrings
	doins debian-archive-keyring-2009.01.31/keyrings/*.gpg || die
}
