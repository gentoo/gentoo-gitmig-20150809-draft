# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh-completion/zsh-completion-20040730.ebuild,v 1.1 2004/11/06 15:39:08 usata Exp $

DESCRIPTION="Programmable Completion for zsh (includes emerge and ebuild commands)"
HOMEPAGE="http://www.zsh.org/"
SRC_URI="http://dev.gentoo.org/~usata/distfiles/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~arm ~hppa ~amd64"
IUSE=""

DEPEND="app-shells/zsh"

src_install() {

	insinto /usr/share/zsh/site-functions
	doins _*

	dodoc README
}
