# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SNMP_Session/SNMP_Session-0.92-r1.ebuild,v 1.4 2003/02/13 11:18:53 vapier Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A SNMP Perl Module"
SRC_URI="ftp://ftp.switch.ch/software/sources/network/snmp/perl/${P}.tar.gz"
HOMEPAGE="http://www.switch.ch/misc/leinen/snmp/perl/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc alpha"

mydoc="README.SNMP_util"

src_install() {

	perl-module_src_install
	dohtml *.html
}
