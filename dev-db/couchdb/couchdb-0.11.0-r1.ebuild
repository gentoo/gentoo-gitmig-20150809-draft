# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/couchdb/couchdb-0.11.0-r1.ebuild,v 1.3 2010/07/17 09:26:02 fauli Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Apache CouchDB is a distributed, fault-tolerant and schema-free document-oriented database."
HOMEPAGE="http://couchdb.apache.org/"
SRC_URI="mirror://apache/couchdb/${PV}/apache-${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

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
		--localstatedir=/var \
		--with-js-lib=/usr/lib
	# bug 296609, upstream bug #COUCHDB-621
	sed -e "s#localdocdir = /usr/share/doc/couchdb#localdocdir = /usr/share/doc/couchdb-0.10.1#" -i Makefile || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	insinto /var/run/couchdb

	fowners couchdb:couchdb \
		/var/run/couchdb \
		/var/lib/couchdb \
		/var/log/couchdb

	fowners root:couchdb /etc/couchdb/*.ini
	fperms 660 /etc/couchdb/*.ini

	newinitd "${FILESDIR}/couchdb.init-0.10" couchdb || die
	newconfd "${FILESDIR}/couchdb.conf-0.10" couchdb || die

	sed -i -e "s:LIBDIR:$(get_libdir):" "${D}/etc/conf.d/couchdb"
}
