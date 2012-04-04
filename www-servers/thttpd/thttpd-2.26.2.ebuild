# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/thttpd/thttpd-2.26.2.ebuild,v 1.1 2012/04/04 12:24:20 blueness Exp $

EAPI="4"

inherit eutils flag-o-matic toolchain-funcs

MY_P="s${P}"

DESCRIPTION="Fork of thttpd, a small, fast, multiplexing webserver."
HOMEPAGE="http://opensource.dyc.edu/sthttpd"
SRC_URI="http://opensource.dyc.edu/pub/sthttpd/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

THTTPD_USER=thttpd
THTTPD_GROUP=thttpd
THTTPD_DOCROOT="/var/www/localhost/htdocs"

DOCS=( README TODO )

pkg_setup() {
	ebegin "Creating thttpd user and group"
	enewgroup ${THTTPD_GROUP}
	enewuser ${THTTPD_USER} -1 -1 -1 ${THTTPD_GROUP}
}

src_configure() {
	econf WEBDIR=${THTTPD_DOCROOT}
}

src_install () {
	default

	newinitd "${FILESDIR}"/thttpd.init thttpd
	newconfd "${FILESDIR}"/thttpd.confd thttpd

	insinto /etc/logrotate.d
	newins "${FILESDIR}/thttpd.logrotate" thttpd

	insinto /etc/thttpd
	doins "${FILESDIR}"/thttpd.conf.sample
}

pkg_postinst() {
	chown root:${THTTPD_GROUP} "${ROOT}/usr/sbin/makeweb" \
		|| die "Failed chown makeweb"
	chmod 2751 "${ROOT}/usr/sbin/makeweb" \
		|| die "Failed chmod makeweb"
	chmod 755 "${THTTPD_DOCROOT}/cgi-bin/printenv" \
		|| die "Failed chmod printenv"
	elog "Adjust THTTPD_DOCROOT in /etc/conf.d/thttpd !"
}
