# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/denyhosts/denyhosts-2.5.ebuild,v 1.5 2006/10/19 15:05:31 kloeri Exp $

inherit distutils eutils

my_PN="DenyHosts"
my_P="${my_PN}-${PV}"
DESCRIPTION="DenyHosts is a utility to help sys admins thwart ssh hackers"
HOMEPAGE="http://www.denyhosts.net"
SRC_URI="mirror://sourceforge/${PN}/${my_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc sparc x86"
IUSE=""
DEPEND=">=dev-lang/python-2.3"
S="${WORKDIR}/${my_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# changes default file installations
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i -e 's:#!/usr/bin/env python:#!/usr/bin/python:' \
		denyhosts.py || die "sed failed"
	sed -i -e 's:DENY_THRESHOLD_VALID = 10:DENY_THRESHOLD_VALID = 5:' \
		denyhosts.cfg-dist || die "sed failed"
}

src_install() {
	distutils_src_install

	insinto /etc
	insopts -m0640
	newins denyhosts.cfg-dist denyhosts.conf

	newinitd "${FILESDIR}"/denyhosts.init denyhosts

	exeinto /usr/bin
	newexe denyhosts.py denyhosts

	dodoc CHANGELOG.txt README.txt

	keepdir /var/lib/denyhosts
}

pkg_postinst() {
	if [ ! -f /etc/hosts.deny ]
	then
		touch /etc/hosts.deny
	fi

	einfo "You can configure DenyHosts to run as a daemon by running:"
	einfo
	einfo "rc-update add denyhosts default"
	einfo
	einfo "or as a cronjob, by adding the following to /etc/crontab"
	einfo "# run DenyHosts every 10 minutes"
	einfo "*/10  *  * * *	root	python /usr/bin/denyhosts -c /etc/denyhosts.conf"
	einfo
	einfo "More information can be found at http://denyhosts.sourceforge.net/faq.html"
	einfo
	ewarn "Modify /etc/denyhosts.conf to suit your environment system."
}

