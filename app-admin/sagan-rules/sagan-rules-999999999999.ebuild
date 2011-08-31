# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sagan-rules/sagan-rules-999999999999.ebuild,v 1.1 2011/08/31 08:30:15 maksbotan Exp $

EAPI=4

inherit git-2

DESCRIPTION="Rules for Sagan log analyzer"
HOMEPAGE="http://sagan.softwink.com/"
EGIT_REPO_URI="https://github.com/beave/sagan-rules.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
PDEPEND="app-admin/sagan"

S="${WORKDIR}"/rules

src_install() {
	insinto /etc/sagan-rules
	doins -r ./* || die
}
