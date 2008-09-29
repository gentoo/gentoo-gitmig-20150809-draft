# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/OpenSRF/OpenSRF-0.9.ebuild,v 1.2 2008/09/29 14:46:47 mr_bones_ Exp $

inherit eutils multilib flag-o-matic apache-module

DESCRIPTION="OpenSRF is a framework that allows the development of software without requiring a detailed knowledge of Evergreen's structure."
HOMEPAGE="http://open-ils.org/"
SRC_URI="http://open-ils.org/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=www-servers/apache-2.2.9
		>=dev-libs/yaz-3.0
		app-dicts/aspell-en
		>=dev-lang/spidermonkey-1.6
		>=dev-db/libdbi-drivers-0.8.2
		>=dev-db/libdbi-0.8.2
		net-im/ejabberd
		dev-libs/libmemcache
		dev-perl/Cache-Memcached
		dev-perl/DateTime
		dev-perl/DateTime-Locale
		dev-perl/DateTime-TimeZone
		dev-perl/DBD-Pg
		dev-perl/Email-Send
		dev-perl/GD-Graph3d
		dev-perl/Log-Log4perl
		dev-perl/JSON-XS
		dev-perl/XML-LibXML
		dev-perl/XML-LibXSLT
		dev-perl/XML-Simple
		dev-perl/Template-Toolkit
		dev-perl/Text-Aspell
		dev-perl/UNIVERSAL-require
		dev-perl/Unix-Syslog
		dev-perl/Text-CSV-Simple
		dev-perl/Text-CSV_XS
		dev-perl/Spreadsheet-WriteExcel
		dev-perl/Tie-IxHash
		dev-perl/Net-XMPP
		dev-perl/Authen-SASL
		dev-perl/XML-Stream
		dev-perl/net-server
		dev-perl/Class-DBI-AbstractSearch
		dev-perl/JavaScript-SpiderMonkey
		dev-perl/MARC-Record
		dev-perl/MARC-Charset
		dev-perl/MARC-XML
		dev-perl/Net-Z3950-ZOOM"

APXS2_S="${S}/src/gateway"
APACHE2_MOD_FILE="${APXS2_S}/osrf_json_gateway.so"
#APACHE2_MOD_CONF="42_${PN}"
#APACHE2_MOD_DEFINE="FOO"
#DOCFILES="docs/*.html"
need_apache2_2

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-0.9-buildfix.patch
}

src_compile() {
	LIBXML2_CFLAGS=$(xml2-config --cflags)
	LIBXML2_CFLAGS="${LIBXML2_CFLAGS//*-I}"
	LIBXML2_HEADERS="${LIBXML2_CFLAGS// *}"
	APR_HEADERS=$(apr-1-config --includedir)
	APACHE2_HEADERS=$(apxs2 -q INCLUDEDIR)
	sed -i \
		-e '/^export PREFIX=/s,/.*,/usr,' \
		-e '/^export BINDIR=/s,/.*,${PREFIX}/bin,' \
		-e "/^export LIBDIR=/s,/.*,\${PREFIX}/$(get_libdir)," \
		-e '/^export PERLDIR=/s,/.*,${LIBDIR}/perl5,' \
		-e '/^export INCLUDEDIR=/s,/.*,${PREFIX}/include,' \
		-e '/^export ETCDIR=/s,/.*,/etc,' \
		-e '/^export SOCK=/s,/.*,/var/run/opensrf,' \
		-e '/^export PID=/s,/.*,/var/run/opensrf,' \
		-e '/^export LOG=/s,/.*,/var/log,' \
		-e '/^export TMP=/s,/.*,/tmp,' \
		-e '/^export APXS2=/s,/.*,/usr/sbin/apxs2,' \
		-e "/^export APACHE2_HEADERS=/s,/.*,${APACHE2_HEADERS}," \
		-e "/^export APR_HEADERS=/s,/.*,${APR_HEADERS}," \
		-e "/^export LIBXML2_HEADERS=/s,/.*,${LIBXML2_HEADERS}," \
		install.conf
	emake verbose || die "Failed to build"
}

src_install() {
	emake install-verbose DESTDIR="${D}" || die "Failed to install"
	apache-module_src_install
	insinto /usr/share/opensrf
	doins src/javascript/*js
	dodoc doc/*
}

pkg_config() {
	JABBER_SERVER=${JABBER_SERVER:=localhost}
	JABBER_PORT=${JABBER_PORT:=5222}
	PASSWORD=${PASSWORD:=osrf}
	einfo "Using Jabber server at ${JABBER_SERVER}:${JABBER_PORT}"
	einfo "Adding 'osrf' and 'router' users with password ${PASSWORD}"
	cd "${ROOT}"/usr/share/doc/${PF}/examples
	for user in osrf router ; do
		perl register.pl ${JABBER_SERVER} ${JABBER_PORT} ${user} ${PASSWORD} \
			|| die "Failed to add $user user to server"
	done
}
