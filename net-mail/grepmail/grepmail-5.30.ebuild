# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/grepmail/grepmail-5.30.ebuild,v 1.3 2004/09/04 13:31:19 gustavoz Exp $

inherit perl-module

DESCRIPTION="Search normal or compressed mailbox using a regular expression or dates."
HOMEPAGE="http://grepmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/grepmail/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/Inline
	dev-perl/TimeDate
	dev-perl/DateManip
	dev-perl/Digest-MD5
	dev-perl/Mail-Mbox-MessageParser"

RDEPEND=""

src_compile () {
	echo "" | perl-module_src_compile
}
