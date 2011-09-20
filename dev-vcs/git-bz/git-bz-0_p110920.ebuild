# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/git-bz/git-bz-0_p110920.ebuild,v 1.1 2011/09/20 14:15:19 mgorny Exp $

EAPI=3
PYTHON_DEPEND=2

inherit python

DESCRIPTION="Bugzilla subcommand for git"
HOMEPAGE="http://www.fishsoup.net/software/git-bz/"
SRC_URI="http://dev.gentoo.org/~mgorny/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-vcs/git"

src_compile() {
	:
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1 || die
	dodoc TODO || die
}
