# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20030505.ebuild,v 1.1 2003/05/16 21:42:30 joker Exp $

S=${WORKDIR}/${PN/-/_}
DESCRIPTION="Programmable Completion for bash (includes emerge and ebuild commands)."
HOMEPAGE="http://www.caliban.org/bash/index.shtml#completion"
SRC_URI="http://www.caliban.org/files/bash/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="sys-apps/tar
	sys-apps/bzip2"

RDEPEND=">=app-shells/bash-2.05a"

src_install() {
	insinto /etc
	doins bash_completion

	insinto /etc/bash_completion.d

	doins contrib/unrar
	doins contrib/harbour
	doins contrib/isql
	doins contrib/larch
	doins contrib/lilypond
	doins contrib/p4
	doins contrib/ri

	newins ${FILESDIR}/gentoo.completion gentoo

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

	if [ -f /etc/bash_completion.d/gentoo.completion ]
	then
		echo
		ewarn "The file 'gentoo.completion' in '/etc/bash_completion.d/' has been"
		ewarn "replaced with 'gentoo'. Remove gentoo.completion to avoid problems."
		echo
	fi
}
