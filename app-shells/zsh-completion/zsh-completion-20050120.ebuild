# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh-completion/zsh-completion-20050120.ebuild,v 1.5 2005/04/01 03:43:20 agriffis Exp $

DESCRIPTION="Programmable Completion for zsh (includes emerge and ebuild commands)"
HOMEPAGE="http://www.zsh.org/"
SRC_URI="http://dev.gentoo.org/~usata/distfiles/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~arm hppa ~amd64 ia64 ppc-macos"
IUSE=""

DEPEND="app-shells/zsh"

#S="${WORKDIR}/${PN}"

src_install() {

	insinto /usr/share/zsh/site-functions
	doins _*

	dodoc README
}
