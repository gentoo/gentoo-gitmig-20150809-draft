# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Device-SerialPort/Device-SerialPort-1.04.ebuild,v 1.2 2011/06/11 21:20:50 maekke Exp $

MODULE_AUTHOR=COOK
inherit perl-module

DESCRIPTION="A Serial port Perl Module"
HOMEPAGE="http://sendpage.org/device-serialport/ http://search.cpan.org/dist/Device-SerialPort/"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

#From the module:
# If you run 'make test', you must make sure that nothing is plugged
# into '/dev/ttyS1'!
# Doesn't sound wise to enable SRC_TEST="do" - mcummings

DEPEND="dev-lang/perl"
