# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20050121-r1.ebuild,v 1.7 2005/03/30 16:10:43 hansmi Exp $

inherit eutils

GENCOMP_VERS="20050117"

DESCRIPTION="Programmable Completion for bash (includes emerge and ebuild commands)"
HOMEPAGE="http://www.caliban.org/bash/index.shtml#completion"
SRC_URI="http://www.caliban.org/files/bash/${P}.tar.bz2
	http://download.berlios.de/gentoo-bashcomp/gentoo-bashcomp-${GENCOMP_VERS}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 ~ppc-macos s390 sparc x86"
IUSE=""

DEPEND="app-arch/tar
	app-arch/bzip2"
RDEPEND="|| (
				>=app-shells/bash-2.05a
				app-shells/zsh
			)"

S="${WORKDIR}/${PN/-/_}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo.diff
	cd ${WORKDIR}/gentoo-bashcomp-${GENCOMP_VERS}
	epatch ${FILESDIR}/gentoo-bashcomp-${GENCOMP_VERS}-equery.diff
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

	# gentoo-bashcomp
	cd ${WORKDIR}/gentoo-bashcomp-${GENCOMP_VERS}
	doins gentoo || die "failed to install gentoo completions"
	dodir /etc/bash_completion.d
	dosym ../../usr/share/bash-completion/gentoo /etc/bash_completion.d/gentoo \
		|| die "dosym gentoo-bashcomp failed"
	docinto gentoo
	dodoc AUTHORS TODO
}

pkg_postinst() {
	echo
	einfo "Add the following line to your ~/.bashrc to"
	einfo "activate completion support in your bash:"
	einfo "[ -f /etc/profile.d/bash-completion ] && . /etc/profile.d/bash-completion"
	einfo
	einfo "Additional complete functions can be enabled by symlinking them from"
	einfo "/usr/share/bash-completion to /etc/bash_completion.d"

	local g="${ROOT}/etc/bash_completion.d/gentoo"
	if [[ -e "${g}" && ! -L "${g}" ]] ; then
		echo
		ewarn "The gentoo completion functions have moved to /usr/share/bash-completion."
		ewarn "Please run etc-update to replace /etc/bash_completion.d/gentoo with a symlink."
	fi
	echo

	if has_version 'app-shells/zsh' ; then
		einfo "If you are interested in using the provided bash completion functions with"
		einfo "zsh, valuable tips on the effective use of bashcompinit are available:"
		einfo "  http://www.zsh.org/mla/workers/2003/msg00046.html"
		einfo "  http://zshwiki.org/ZshSwitchingTo"
		echo
	fi
}
