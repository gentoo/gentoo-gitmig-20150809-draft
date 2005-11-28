# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/grepmail/grepmail-5.30.ebuild,v 1.8 2005/11/28 13:05:52 mcummings Exp $

inherit perl-app

DESCRIPTION="Search normal or compressed mailbox using a regular expression or dates."
HOMEPAGE="http://grepmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/grepmail/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc ~amd64 sparc"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/Inline
	dev-perl/TimeDate
	dev-perl/DateManip
	perl-core/Digest-MD5
	dev-perl/Mail-Mbox-MessageParser"

RDEPEND=""

src_compile () {
	echo "" | perl-app_src_compile
}
