# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20050121-r5.ebuild,v 1.1 2005/03/29 12:49:53 ka0ttic Exp $

inherit eutils

DESCRIPTION="Programmable Completion for bash"
HOMEPAGE="http://www.caliban.org/bash/index.shtml#completion"
SRC_URI="http://www.caliban.org/files/bash/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sparc ~x86"
IUSE=""

DEPEND="app-arch/tar
	app-arch/bzip2"
RDEPEND="|| (
				>=app-shells/bash-2.05a
				app-shells/zsh
			)"
PDEPEND="app-shells/gentoo-bashcomp"

S="${WORKDIR}/${PN/-/_}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo.diff
	epatch ${FILESDIR}/${PV}-muttng.diff
	epatch ${FILESDIR}/${PV}-tar.diff
}

src_install() {
	insinto /etc
	doins bash_completion || die "failed to install bash_completion"
	exeinto /etc/profile.d
	doexe ${FILESDIR}/bash-completion || die "failed to install profile.d"

	# dev-util/subversion provides an extremely superior completion
	rm contrib/subversion
	insinto /usr/share/bash-completion
	doins contrib/* || die "failed to install contrib completions"

	dodoc Changelog README
}

pkg_postinst() {
	echo
	einfo "Add the following line to your ~/.bashrc to"
	einfo "activate completion support in your bash:"
	einfo "[ -f /etc/profile.d/bash-completion ] && . /etc/profile.d/bash-completion"
	einfo
	einfo "Additional complete functions can be enabled by symlinking them from"
	einfo "/usr/share/bash-completion to /etc/bash_completion.d"
	echo

	if has_version 'app-shells/zsh' ; then
		einfo "If you are interested in using the provided bash completion functions with"
		einfo "zsh, valuable tips on the effective use of bashcompinit are available:"
		einfo "  http://www.zsh.org/mla/workers/2003/msg00046.html"
		einfo "  http://zshwiki.org/ZshSwitchingTo"
		echo
	fi
}
