# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SNMP_Session/SNMP_Session-1.12.ebuild,v 1.1 2009/01/30 08:02:06 tove Exp $

inherit perl-module

DESCRIPTION="A SNMP Perl Module"
SRC_URI="http://www.switch.ch/misc/leinen/snmp/perl/dist/${P}.tar.gz"
HOMEPAGE="http://www.switch.ch/misc/leinen/snmp/perl/"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

mydoc="README.SNMP_util"

src_install() {
	perl-module_src_install
	dohtml *.html
}
