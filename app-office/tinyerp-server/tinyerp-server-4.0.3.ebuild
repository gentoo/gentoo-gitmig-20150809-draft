# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/tinyerp-server/tinyerp-server-4.0.3.ebuild,v 1.5 2009/08/28 13:57:17 betelgeuse Exp $

EAPI="2"

inherit eutils distutils

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://tinyerp.org/"
SRC_URI="http://www.tinyerp.org/download/old/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=virtual/postgresql-server-7.4
	dev-python/pypgsql
	dev-python/reportlab
	dev-python/pyparsing
	media-gfx/pydot
	=dev-python/psycopg-1*
	dev-libs/libxml2
	dev-libs/libxslt[python]
	dev-python/pychart"

TINYERP_USER=terp
TINYERP_GROUP=terp

src_prepare() {
	epatch "${FILESDIR}"/${P}-setup.patch
}

src_install() {
	distutils_src_install

	newinitd "${FILESDIR}"/tinyerp-init.d tinyerp
	newconfd "${FILESDIR}"/tinyerp-conf.d tinyerp

	keepdir /var/run/tinyerp
	keepdir /var/log/tinyerp
}

pkg_preinst() {
	enewgroup ${TINYERP_GROUP}
	enewuser ${TINYERP_USER} -1 -1 -1 ${TINYERP_GROUP}

	fowners ${TINYERP_USER}:${TINYERP_GROUP} /var/run/tinyerp
	fowners ${TINYERP_USER}:${TINYERP_GROUP} /var/log/tinyerp
}

pkg_postinst() {
	elog "In order to setup the initial database, run:"
	elog "  emerge --config =${CATEGORY}/${PF}"
	elog "Be sure the database is started before"
}

pquery() {
	psql -q -At -U postgres -d template1 -c "$@"
}

pkg_config() {
	einfo "In the following, the 'postgres' user will be used."
	if ! pquery "SELECT usename FROM pg_user WHERE usename = '${TINYERP_USER}'" | grep -q ${TINYERP_USER}; then
		ebegin "Creating database user ${TINYERP_USER}"
		createuser --quiet --username=postgres --createdb --no-adduser ${TINYERP_USER}
		eend $? || die "Failed to create database user"
	fi
}
