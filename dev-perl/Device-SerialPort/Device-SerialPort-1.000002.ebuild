# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Device-SerialPort/Device-SerialPort-1.000002.ebuild,v 1.8 2006/08/05 02:58:17 mcummings Exp $

inherit perl-module

DESCRIPTION="A Serial port Perl Module"
HOMEPAGE="http://sendpage.org/device-serialport/"
SRC_URI="http://sendpage.org/device-serialport/download/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ~ppc sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
