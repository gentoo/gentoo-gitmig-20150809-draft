# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpdbg/phpdbg-2.10.ebuild,v 1.2 2002/07/17 03:24:39 rphillips Exp $

PL="pl3"
S=${WORKDIR}/dbg-${PV}${PL}
DESCRIPTION="Ruby/DBI - a database independent interface for accessing databases - similar to Perl's DBI"
SRC_URI="http://dd.cron.ru/dbg/dnld/dbg-${PV}${PL}.tar.gz"
HOMEPAGE="http://dd.cron.ru/dbg/"
SLOT="0"
LICENSE="dbgphp"
DEPEND="virtual/php"

# support ppc? or others?
KEYWORDS="x86"

src_compile() {
	phpize
	./configure --with-extensions-flag
	make
}

src_install () {
	echo test
}

