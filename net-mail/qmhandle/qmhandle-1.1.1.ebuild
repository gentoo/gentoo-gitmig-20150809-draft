# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmhandle/qmhandle-1.1.1.ebuild,v 1.12 2005/03/03 16:28:56 ciaranm Exp $

inherit eutils

DESCRIPTION="Qmail message queue tool"
HOMEPAGE="http://qmhandle.sourceforge.net/"
SRC_URI="mirror://sourceforge/qmhandle/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="|| ( mail-mta/qmail mail-mta/qmail-mysql mail-mta/qmail-ldap )
	dev-lang/perl
	sys-process/psmisc"
DEPEND=""
S=${WORKDIR}


src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/qmHandle-gentoo.patch
}

src_compile() {
	einfo "Nothing to compile :-)"
}

src_install() {
	dobin qmHandle || die
	dodoc README HISTORY
}
