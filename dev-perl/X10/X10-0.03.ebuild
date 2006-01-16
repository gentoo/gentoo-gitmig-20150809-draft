# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/X10/X10-0.03.ebuild,v 1.1 2006/01/16 19:27:44 mcummings Exp $

inherit perl-module

DESCRIPTION="Modules for communicating with X10 devices"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/R/RO/ROBF/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Device-SerialPort
		dev-perl/Astro-SunTime
		dev-perl/Time-modules"
