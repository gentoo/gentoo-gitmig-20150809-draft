# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/man2html/man2html-1.5l-r2.ebuild,v 1.7 2004/09/05 21:33:23 kloeri Exp $

inherit eutils webapp

DESCRIPTION="Convert manual pages to HTML"
HOMEPAGE="http://freshmeat.net/projects/man/"
SRC_URI="mirror://kernel/linux/utils/man/man-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="alpha sparc x86 ~ia64 ~ppc"
IUSE=""

DEPEND="app-misc/glimpse
	sys-apps/gawk
	sys-apps/man"

S=${WORKDIR}/man-${PV}

pkg_setup() {
	webapp_pkg_setup
	einfo "Installing into ${MY_HOSTROOTDIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/mansearch-gentoo.patch
	epatch ${FILESDIR}/manwhatis-gentoo.patch
	epatch ${FILESDIR}/mansec.patch
	find man2html -type f | xargs sed -i -e  "s:/home/httpd/htdocs/:/var/www/localhost/:g"
	find man2html -type f | xargs sed -i -e  "s:/home/httpd/cgi-bin/:/var/www/localhost/cgi-bin/man:g"
	find man2html -type f | xargs sed -i -e  "s:/home/httpd/cgi-aux/man:/var/www/localhost/cgi-aux/man:g"
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
	doexe ${FILESDIR}/man2html.cron

	webapp_src_install
}
