# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/grepmail/grepmail-4.70-r2.ebuild,v 1.4 2003/09/05 09:04:06 msterret Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Search normal or compressed mailbox using a regular expression or dates."
HOMEPAGE="http://grepmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/grepmail/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc "

DEPEND="${DEPEND}
	dev-perl/Inline
	dev-perl/TimeDate
	dev-perl/DateManip
	dev-perl/Digest-MD5
	dev-perl/Parse-RecDescent"

RDEPEND=""

src_compile () {

	echo "" | perl-module_src_compile
}
