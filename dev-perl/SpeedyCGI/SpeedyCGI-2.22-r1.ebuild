# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SpeedyCGI/SpeedyCGI-2.22-r1.ebuild,v 1.1 2010/03/29 14:59:14 pva Exp $

inherit perl-module

DESCRIPTION="Speed up perl scripts by running them persistently"
HOMEPAGE="http://daemoninc.com/SpeedyCGI/"
SRC_URI="http://daemoninc.com/SpeedyCGI/CGI-${P}.tar.gz
	http://oss.oetiker.ch/smokeping/pub/speedy-error.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/CGI-${P}

PATCHES=( "${DISTDIR}/speedy-error.patch" 
"${FILESDIR}/${P}-makefile-manpage.patch"
"${FILESDIR}/${P}-empty-param.patch"
"${FILESDIR}/${P}-strerror.patch"
"${FILESDIR}/${P}-apache-docs.patch"
"${FILESDIR}/${P}-apache2.2.patch"
"${FILESDIR}/${P}-strip-backend-libs.patch"
"${FILESDIR}/${P}-test-timeout.patch"
"${FILESDIR}/${P}-speedy_unsafe_putenv.patch"
"${FILESDIR}/${P}-perl5.10.patch"
"${FILESDIR}/${P}-perl_sys_init.patch"
"${FILESDIR}/${P}-uninit-crash.patch"
)

MAKEOPTS="${MAKEOPTS} -j1"
