# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20060301.ebuild,v 1.8 2009/02/08 22:30:00 josejx Exp $

inherit eutils

DESCRIPTION="Programmable Completion for bash"
HOMEPAGE="http://www.caliban.org/bash/index.shtml#completion"
SRC_URI="http://www.caliban.org/files/bash/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND="|| (
				>=app-shells/bash-2.05a
				app-shells/zsh
			)"
PDEPEND="app-shells/gentoo-bashcomp"

S="${WORKDIR}/${PN/-/_}"

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_SUFFIX="diff" epatch ${FILESDIR}/20050721
	EPATCH_SUFFIX="diff" epatch ${FILESDIR}/${PV}
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
	elog "Add the following to your ~/.bashrc to enable completion support."
	elog "NOTE: to avoid things like Gentoo bug #98627, you should set aliases"
	elog "after sourcing /etc/profile.d/bash-completion."
	elog
	elog "[[ -f /etc/profile.d/bash-completion ]] && \\ "
	elog "    source /etc/profile.d/bash-completion"
	elog
	elog "Additional completion functions can be enabled by installing"
	elog "app-admin/eselect and using the included bashcomp module."
	echo

	if has_version 'app-shells/zsh' ; then
		elog "If you are interested in using the provided bash completion functions with"
		elog "zsh, valuable tips on the effective use of bashcompinit are available:"
		elog "  http://www.zsh.org/mla/workers/2003/msg00046.html"
		elog "  http://zshwiki.org/ZshSwitchingTo"
		echo
	fi
}
