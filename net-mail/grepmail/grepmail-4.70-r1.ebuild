# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/grepmail/grepmail-4.70-r1.ebuild,v 1.2 2002/07/17 06:38:03 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Search normal or compressed mailbox using a regular expression or dates."
HOMEPAGE="http://grepmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/grepmail/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

DEPEND="${DEPEND}
	dev-perl/Inline
	dev-perl/TimeDate
	dev-perl/DateManip"

src_compile () {

	echo "" | base_src_compile
	base_src_test || die
}
