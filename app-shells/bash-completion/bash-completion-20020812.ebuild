# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20020812.ebuild,v 1.3 2002/08/16 02:37:45 murphy Exp $

S=${WORKDIR}/${PN/-/_}

DESCRIPTION="Programmable Completion for bash (includes emerge and ebuild commands)."
SRC_URI="http://www.caliban.org/files/bash/${P}.tar.bz2"
HOMEPAGE="http://www.caliban.org/bash/index.shtml#completion"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND=">=sys-apps/bash-2.05a"

src_install () {
	insinto /etc
	doins bash_completion

	insinto /etc/bash_completion.d

	doins contrib/dict
	doins contrib/harbour
	doins contrib/isql
	doins contrib/larch
	doins contrib/lilypond
	doins contrib/p4
	doins contrib/ri

	doins ${FILESDIR}/gentoo.completion

	insinto /etc/profile.d
	doins ${FILESDIR}/bash-completion

	dodoc COPYING Changelog README
}

pkg_postinst() {
	einfo "Add the following line to your ~/.bashrc to"
	einfo "activate completion support in your bash:"
	einfo "[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion"
}
