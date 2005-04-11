# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ciabot-svn/ciabot-svn-1.15.ebuild,v 1.1 2005/04/11 01:18:00 trapni Exp $

inherit eutils

DESCRIPTION="CIA-bot script for Subversion repositories"
HOMEPAGE="http://cia.navi.cx/doc/clients"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64"
IUSE=""

DEPEND="dev-lang/python"

S="${WORKDIR}"

src_install() {
	dodir /etc/${PN}
	insinto /etc/${PN}
	doins ${FILESDIR}/config.py

	newbin ${P}.py ${PN} || die
}

pkg_postinst() {
	echo
	einfo "This ciabot-svn script should be called from your repository's post-commit"
	einfo "hook with the repository and revision as arguments. For example,"
	einfo "you could copy this script into your repository's \"hooks\" directory"
	einfo "and add something like the following to the \"post-commit\" script,"
	einfo "also in the repository's \"hooks\" directory:"
	einfo ""
	einfo "  REPOS=\"\$1\""
	einfo "  REV=\"\$2\""
	einfo "  /usr/bin/ciabot-svn \"\$REPOS\" \"\$REV\" &"
	einfo ""
	einfo "Or, if you have multiple project hosted, you can add each"
	einfo "project's name to the commandline in that project's post-commit"
	einfo "hook:"
	einfo ""
	einfo "  /usr/bin/ciabot-svn \"\$REPOS\" \"\$REV\" \"ProjectName\" &"
	echo
	ebeep
	epause
}
