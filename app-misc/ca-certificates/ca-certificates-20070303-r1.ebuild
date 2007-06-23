# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ca-certificates/ca-certificates-20070303-r1.ebuild,v 1.2 2007/06/23 02:38:57 dsd Exp $

inherit eutils

DESCRIPTION="Common CA Certificates PEM files"
HOMEPAGE="http://www.cacert.org/"
SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${PV}_all.deb"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=">=sys-apps/portage-2.1.2"
RDEPEND="dev-libs/openssl"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
	rm -f control.tar.gz data.tar.gz debian-binary
}

src_install() {
	cp -pPR * "${D}"/ || die "installing data failed"

	(
	cd "${D}"/usr/share/ca-certificates
	find . -name '*.crt' | sort | cut -b3-
	) > "${D}"/etc/ca-certificates.conf

	mv "${D}"/usr/share/doc/{ca-certificates,${PF}} || die
	prepalldocs
}

pkg_postinst() {
	[[ ${ROOT} != "/" ]] && return 0
	update-ca-certificates
}
