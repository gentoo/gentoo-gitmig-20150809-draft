# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/git-sh/git-sh-1.0-r1.ebuild,v 1.2 2010/03/17 16:36:41 sping Exp $

EAPI="2"

DESCRIPTION="A customized bash environment suitable for git work."
HOMEPAGE="http://github.com/rtomayko/git-sh"
SRC_URI="http://github.com/rtomayko/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-vcs/git"

S="${WORKDIR}/rtomayko-${PN}-bedba53"

src_prepare() {
	sed -e 's/git-completion\.bash //' -i Makefile || die "sed failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	insinto /usr/share/${PN}
	doins gitshrc-example.bash || die "doins failed"
	dodoc README.markdown || die "dodoc failed"
}

pkg_postinst() {
	einfo
	einfo "For bash completion in git commands emerge dev-vcs/git"
	einfo "with bash-completion USE flag."
	einfo
}
