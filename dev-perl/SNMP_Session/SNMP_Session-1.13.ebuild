# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SNMP_Session/SNMP_Session-1.13.ebuild,v 1.3 2010/04/17 08:34:11 tove Exp $

inherit perl-module

DESCRIPTION="A SNMP Perl Module"
SRC_URI="http://snmp-session.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="http://code.google.com/p/snmp-session/"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc x86 ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl"

mydoc="README.SNMP_util"

src_install() {
	perl-module_src_install
	dohtml *.html
}
