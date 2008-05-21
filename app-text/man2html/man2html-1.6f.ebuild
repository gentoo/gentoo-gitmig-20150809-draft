# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/man2html/man2html-1.6f.ebuild,v 1.1 2008/05/21 23:35:12 mpagano Exp $

inherit eutils webapp

DESCRIPTION="Convert manual pages to HTML"
HOMEPAGE="http://freshmeat.net/projects/man/"
SRC_URI="mirror://kernel/linux/utils/man/man-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-misc/glimpse
	sys-apps/gawk
	virtual/man"

S=${WORKDIR}/man-${PV}

pkg_setup() {
	webapp_pkg_setup
	einfo "Installing into ${MY_HOSTROOTDIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/mansearch-gentoo.patch
	epatch "${FILESDIR}"/mansec-${PV}.patch
	find man2html -type f | xargs sed -i \
		-e "s:/home/httpd/htdocs/:/var/www/localhost/:g" \
		-e "s:/home/httpd/cgi-bin/:/var/www/localhost/cgi-bin/man:g" \
		-e "s:/home/httpd/cgi-aux/man:/var/www/localhost/cgi-aux/man:g"
}

src_compile() {
	:
}

src_install() {
	webapp_src_preinst

	cd man2html
	exeinto ${MY_HOSTROOTDIR}/cgi-bin/man
	doexe scripts/cgi-bin/man/*
	insinto ${MY_HOSTROOTDIR}/cgi-aux/man
	doins scripts/cgi-aux/man/*
	insinto /var/man2html
	newins glimpse_filters .glimpse_filters
	fperms 1777 /var/man2html
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/man2html.cron man2html

	webapp_src_install
}
