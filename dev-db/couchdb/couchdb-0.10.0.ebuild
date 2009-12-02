# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/couchdb/couchdb-0.10.0.ebuild,v 1.4 2009/12/02 10:48:08 maekke Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Apache CouchDB is a distributed, fault-tolerant and schema-free document-oriented database."
HOMEPAGE="http://couchdb.apache.org/"
SRC_URI="mirror://apache/couchdb/${PV}/apache-${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-libs/icu
		dev-lang/erlang[ssl]
		>=dev-libs/openssl-0.9.8j
		>=net-misc/curl-7.18.2
		dev-lang/spidermonkey"

DEPEND="${RDEPEND}"

S="${WORKDIR}/apache-${P}"

pkg_setup() {
	enewgroup couchdb
	enewuser couchdb -1 /bin/bash /var/lib/couchdb couchdb
}

src_configure() {
	econf \
		--with-erlang=/usr/lib/erlang/usr/include \
		--localstatedir=/var
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	insinto /var/run/couchdb

	fowners couchdb:couchdb \
		/var/run/couchdb \
		/var/lib/couchdb \
		/var/log/couchdb

	newinitd "${FILESDIR}/couchdb.init-0.10" couchdb || die
	newconfd "${FILESDIR}/couchdb.conf-0.10" couchdb || die

	sed -i -e "s:LIBDIR:$(get_libdir):" "${D}/etc/conf.d/couchdb"
}
