# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/grepmail/grepmail-4.70-r1.ebuild,v 1.5 2002/08/14 12:05:25 murphy Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Search normal or compressed mailbox using a regular expression or dates."
HOMEPAGE="http://grepmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/grepmail/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="${DEPEND}
	dev-perl/Inline
	dev-perl/TimeDate
	dev-perl/DateManip
	dev-perl/Digest-MD5
	dev-perl/Parse-RecDescent"

RDEPEND=""
	
src_compile () {

	echo "" | perl-module_src_compile
	perl-module_src_test || die
}
