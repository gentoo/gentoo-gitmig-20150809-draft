# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/build-docbook-catalog/build-docbook-catalog-1.4.ebuild,v 1.11 2011/03/29 02:17:56 flameeyes Exp $

DESCRIPTION="DocBook XML catalog auto-updater"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~flameeyes/${PN}/${P}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( sys-apps/util-linux app-misc/getopt )
	!<app-text/docbook-xsl-stylesheets-1.73.1"
DEPEND=""

S=${WORKDIR}

src_install() {
	keepdir /etc/xml
	newbin ${P} ${PN} || die
}
