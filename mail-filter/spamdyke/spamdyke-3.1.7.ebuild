# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamdyke/spamdyke-3.1.7.ebuild,v 1.2 2008/05/13 20:52:35 tupone Exp $

EAPI="1"

inherit eutils autotools

DESCRIPTION="A drop-in connection-time spam filter for qmail"
HOMEPAGE="http://www.spamdyke.org/"
SRC_URI="http://www.spamdyke.org/releases/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+tls"

DEPEND="tls? ( dev-libs/openssl )"

S=${WORKDIR}/${P}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-nested.patch
	echo "# Configuration option for ${PN}" > ${PN}.conf
	if use tls; then
		echo "tls-certificate-file=/var/qmail/control/clientcert.pem" \
			>> ${PN}.conf
	fi
	echo "graylist-dir=/var/tmp/${PN}/graylist" >> ${PN}.conf
	echo "never-graylist-rdns-dir=/etc/${PN}/never-graylist" >> ${PN}.conf
	echo "reject-empty-rdns" >> ${PN}.conf
	echo "reject-unresolvable-rdns" >> ${PN}.conf
	eautoreconf
}

src_compile() {
	econf --with-debug \
		$(use_enable tls) || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
	cd ../utils
	econf || die "econf failed in utils"
	emake CFLAGS="${CFLAGS}" || die "emake in utils died"
}

src_install() {
	dobin ${PN} || die "Installing ${PN} binary failed"
	insinto /etc/${PN}
	doins ${PN}.conf || die "Installing ${PN} configuration file failed"
	keepdir /var/tmp/${PN}/graylist/$(../utils/domain2path -d localhost)
	fowners -R qmaild /var/tmp/${PN}
	insinto /etc/${PN}/never-graylist/$(../utils/domain2path -d localhost)
	touch localhost
	doins localhost
	cd ../utils
	dobin domain2path || die "Installing domain2path binary failed"
	cd ../documentation
	dodoc {Changelog,INSTALL,UPGRADING}.txt
	dohtml FAQ.html \
		README.html \
		README_ip_file_format.html \
		README_rdns_directory_format.html \
		README_rdns_file_format.html
}

pkg_postinst() {
	elog "In /var/qmail/control/conf-smtpd insert the line:"
	elog "QMAIL_SMTP_PRE=\"\${QMAIL_SMTP_PRE} spamdyke -f /etc/${PN}/${PN}.conf\""
	elog "Run spamdyke with the '-h' flag to see the available options and"
	elog "update /etc/spamdyke.conf accordingly"
}
