# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ca-certificates/ca-certificates-20050518.ebuild,v 1.2 2005/05/24 22:00:23 vapier Exp $

inherit eutils

DESCRIPTION="Common CA Certificates PEM files"
HOMEPAGE="http://www.cacert.org/"
SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${PV}_all.deb"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips m68k ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="dev-libs/openssl"

S=${WORKDIR}

src_unpack() {
	echo ">>> Unpacking ${A} to ${PWD}"
	cp "${DISTDIR}"/${A} .
	ar x ${A} || die "failure unpacking ${A}"
}

src_install() {
	cd "${D}"
	tar zxf "${S}"/data.tar.gz || die "installing data failed"
	find "${D}"/usr/share/ca-certificates -name '*.crt' -printf '%P\n' \
		| sort > etc/ca-certificates.conf
}

pkg_postinst() {
	[[ ${ROOT} != "/" ]] && return 0
	update-ca-certificates
}
