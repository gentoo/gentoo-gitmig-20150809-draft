# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20020616.ebuild,v 1.1 2002/06/17 13:35:39 bangert Exp $

S=${WORKDIR}/bash_completion

DESCRIPTION="Programmable Completion for bash (includes emerge and ebuild commands)."
SRC_URI="http://www.caliban.org/files/bash/${P}.tar.gz"
HOMEPAGE="http://www.caliban.org/bash/index.shtml#completion"

RDEPEND=">=sys-apps/bash-2.05a"

LICENSE="GPL-2"

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

    dodoc COPYING Changelog README

}

pkg_postinst() {

    echo
    einfo "See /usr/share/doc/${P}/README.gz on how to "
    einfo "add completion support to your bash"
    echo

}
