# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SNMP_Session/SNMP_Session-0.92-r1.ebuild,v 1.8 2005/08/26 00:08:11 agriffis Exp $

inherit perl-module

DESCRIPTION="A SNMP Perl Module"
SRC_URI="ftp://ftp.switch.ch/software/sources/network/snmp/perl/${P}.tar.gz"
HOMEPAGE="http://www.switch.ch/misc/leinen/snmp/perl/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

mydoc="README.SNMP_util"

src_install() {

	perl-module_src_install
	dohtml *.html
}
