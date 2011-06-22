# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mongodb/mongodb-1.6.5-r1.ebuild,v 1.2 2011/06/22 05:26:54 nirbheek Exp $

EAPI=4
SCONS_MIN_VERSION="1.2.0"

inherit eutils multilib scons-utils versionator

MY_P=${PN}-src-r${PV/_rc/-rc}

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="http://www.mongodb.org"
SRC_URI="http://downloads.mongodb.org/src/${MY_P}.tar.gz"

LICENSE="AGPL-3 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs v8"

RDEPEND="!v8? ( >=dev-lang/spidermonkey-1.8 )
	v8? ( dev-lang/v8 )
	dev-libs/boost
	dev-libs/libpcre[cxx]
	net-libs/libpcap"
DEPEND="${RDEPEND}
	sys-libs/readline
	sys-libs/ncurses"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	enewgroup mongodb
	enewuser mongodb -1 -1 /var/lib/${PN} mongodb

	scons_opts=" --cxx=$(tc-getCXX) --sharedclient"
	if use v8; then
		scons_opts+=" --usev8"
	else
		scons_opts+=" --usesm"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.6-fix-scons.patch"
}

src_compile() {
	escons ${scons_opts} all
}

src_install() {
	escons ${scons_opts} --full --nostrip install --prefix="${D}"/usr

	use static-libs || rm "${D}/usr/$(get_libdir)/libmongoclient.a"

	for x in /var/{lib,log,run}/${PN}; do
		keepdir "${x}"
		fowners mongodb:mongodb "${x}"
	done

	doman debian/mongo*.1
	dodoc README docs/building.md

	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}

	# Remove unsupported options
	sed -i -e '/--unixSocketPrefix/d' "${D}/etc/init.d/${PN}"
	sed -i -e 's/--journal//g' "${D}/etc/conf.d/${PN}"
}

src_test() {
	escons ${scons_opts} smoke --smokedbprefix='testdir' test
}

pkg_postinst() {
	if [[ ${REPLACING_VERSIONS} < 1.6 ]]; then
		ewarn "You just upgraded from a previous version of mongodb !"
		ewarn "Make sure you run 'mongod --upgrade' before using this version."
	fi
}
