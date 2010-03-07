# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mongodb/mongodb-1.2.2.ebuild,v 1.1 2010/03/07 23:39:41 ramereth Exp $

EAPI="2"

inherit eutils versionator

MY_PATCHVER=$(get_version_component_range 1-2)

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="http://www.mongodb.org"
SRC_URI="http://github.com/mongodb/mongo/tarball/r${PV} -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/spidermonkey[unicode]
	dev-libs/boost
	dev-libs/libpcre"

DEPEND="${RDEPEND}
	>=dev-util/scons-1.2.0-r1"

# Must change this on every upgrade
S=${WORKDIR}/${PN}-mongo-8a4fb8b

pkg_setup() {
	enewgroup mongodb
	enewuser mongodb -1 -1 /var/lib/${PN} mongodb
}

src_prepare() {
	epatch "${FILESDIR}"/"${PN}"-"${MY_PATCHVER}"-modify-*.patch
}

src_compile() {
	scons ${MAKEOPTS} all || die "Compile failed"
}

src_install() {
	scons ${MAKEOPTS} install --prefix="${D}"/usr || die "Install failed"

	for x in /var/{lib,log,run}/${PN}; do
		dodir "${x}" || die "Install failed"
		fowners mongodb:mongodb "${x}"
	done

	doman debian/mongo*.1 || die "Install failed"
	dodoc README docs/building.md

	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die "Install failed"
	newconfd "${FILESDIR}/${PN}.confd" ${PN} || die "Install failed"
}

src_test() {
	scons ${MAKEOPTS} smoke test || die "Tests failed"
}

pkg_preinst() {
	has_version '<dev-db/mongodb-1.2'
	PREVIOUS_LESS_THAN_1_2=$?
}

pkg_postinst() {
	if [[ ${PREVIOUS_LESS_THAN_1_2} -eq 0 ]]; then
		ewarn "You need to upgrade your database before proceeding! Steps:"
		ewarn "   /etc/init.d/mongodb stop"
		ewarn "   mongod --upgrade"
		ewarn "   /etc/init.d/mongodb start"
		ewarn "For more info about upgrading, please visit:"
		ewarn "http://www.mongodb.org/display/DOCS/1.2.0+Release+Notes"
	fi;
}
