# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SNMP_Session/SNMP_Session-0.92.ebuild,v 1.4 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A SNMP Perl Module"
SRC_URI="ftp://ftp.switch.ch/software/sources/network/snmp/perl/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.switch.ch/misc/leinen/snmp/perl/"
mydoc="README.SNMP_util"

src_install() {

	base_src_install
	dohtml *.html
}
