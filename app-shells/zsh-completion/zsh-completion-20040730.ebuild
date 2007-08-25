# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh-completion/zsh-completion-20040730.ebuild,v 1.9 2007/08/25 13:36:18 vapier Exp $

DESCRIPTION="Programmable Completion for zsh (includes emerge and ebuild commands)"
HOMEPAGE="http://www.zsh.org/"
SRC_URI="http://dev.gentoo.org/~usata/distfiles/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ~ia64 ppc ~sparc x86"
IUSE=""

DEPEND="app-shells/zsh"

src_install() {

	insinto /usr/share/zsh/site-functions
	doins _*

	dodoc README
}

pkg_postinst() {
	elog
	elog "If you happen to compile your functions, you may need to delete"
	elog "~/.zcompdump{,.zwc} and recompile to make zsh-completion available"
	elog "to your shell."
	elog
}
