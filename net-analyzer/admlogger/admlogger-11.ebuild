# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/admlogger/admlogger-11.ebuild,v 1.1.1.1 2005/11/30 10:12:21 chriswhite Exp $

inherit eutils

DESCRIPTION="a log analyzing engine based on fireparse."
HOMEPAGE="http://aaron.marasco.com/linux.html"
SRC_URI="http://aaron.marasco.com/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="dhcp pureftp logrotate"

DEPEND="dev-lang/perl
		virtual/mta
		pureftp? (net-ftp/pure-ftpd)
		dhcp? (net-misc/dhcp)
		logrotate? (app-admin/logrotate)"
RDEPEND=""
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${P}-makefile.patch
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	chmod a+x pconfig.pl
	make DESTDIR=${D} admlogger
	make DESTDIR=${D} fireparse
	use dhcp && make DESTDIR=${D} dhcp
	use logrotate && make DESTDIR=${D} logrotate
	use pureftp && make DESTDIR=${D} pureftp
}
