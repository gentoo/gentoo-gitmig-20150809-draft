# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libxcrypt/libxcrypt-2.4.ebuild,v 1.1 2010/01/12 11:42:33 phajdan.jr Exp $

EAPI=2

inherit multilib

DESCRIPTION="A replacement for libcrypt with DES, MD5 and blowfish support"
SRC_URI="mirror://debian/pool/main/libx/${PN}/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://packages.debian.org/sid/libxcrypt1"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_configure() {
	# Do not install into /usr so that tcb and pam can use us.
	econf --libdir=/$(get_libdir)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"

	# Remove unneeded files from /
	rm -f "${D}"/$(get_libdir)/"${PN}".{a,la} || die "rm failed"
}
