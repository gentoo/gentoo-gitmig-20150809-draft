# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20020621.ebuild,v 1.1 2002/06/21 15:03:37 bangert Exp $

S=${WORKDIR}/bash_completion

DESCRIPTION="Programmable Completion for bash (includes emerge and ebuild commands)."
SRC_URI="http://www.caliban.org/files/bash/${P}.tar.gz"
HOMEPAGE="http://www.caliban.org/bash/index.shtml#completion"
LICENSE="GPL-2"

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

	echo
	einfo "Add the following line to your ~/.bashrc to"
	einfo "activate completion support in your bash:"
	einfo "[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion"
	echo

}
