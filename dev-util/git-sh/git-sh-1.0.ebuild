# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/git-sh/git-sh-1.0.ebuild,v 1.1 2009/11/28 10:13:32 ayoy Exp $

EAPI="2"

DESCRIPTION="A customized bash environment suitable for git work."
HOMEPAGE="http://github.com/rtomayko/git-sh"
SRC_URI="http://github.com/rtomayko/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-util/git"

S="${WORKDIR}/rtomayko-${PN}-bedba53"

src_install() {
	dobin ${PN} || die "dobin failed"
	insinto /usr/share/${PN}
	doins gitshrc-example.bash || die "doins failed"
	dodoc README.markdown || die "dodoc failed"
}
