# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SNMP_Session/SNMP_Session-0.92.ebuild,v 1.16 2004/07/14 20:25:32 agriffis Exp $

inherit perl-module

DESCRIPTION="A SNMP Perl Module"
SRC_URI="ftp://ftp.switch.ch/software/sources/network/snmp/perl/${P}.tar.gz"
HOMEPAGE="http://www.switch.ch/misc/leinen/snmp/perl/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

mydoc="README.SNMP_util"

src_install() {

	perl-module_src_install
	dohtml *.html
}
