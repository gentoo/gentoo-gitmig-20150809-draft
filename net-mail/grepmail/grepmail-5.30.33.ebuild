# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/grepmail/grepmail-5.30.33.ebuild,v 1.2 2008/03/06 11:37:00 cla Exp $

inherit versionator perl-app

MY_P="${PN}-$(delete_version_separator 2)"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Search normal or compressed mailbox using a regular expression or dates."
HOMEPAGE="http://grepmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/grepmail/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-perl/Inline
	dev-perl/TimeDate
	dev-perl/DateManip
	virtual/perl-Digest-MD5
	>=dev-perl/Mail-Mbox-MessageParser-1.40.01"

SRC_TEST="do"
