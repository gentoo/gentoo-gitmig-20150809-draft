# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20041017-r3.ebuild,v 1.1 2004/12/06 16:28:44 ka0ttic Exp $

inherit eutils

GENCOMP_VERS="1.0_beta4"

DESCRIPTION="Programmable Completion for bash (includes emerge and ebuild commands)"
HOMEPAGE="http://www.caliban.org/bash/index.shtml#completion"
SRC_URI="http://www.caliban.org/files/bash/${P}.tar.bz2
	mirror://sourceforge/gentoo-bashcomp/gentoo-bashcomp-${GENCOMP_VERS}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~s390 ~sparc ~x86 ~ppc64"
IUSE=""

DEPEND="app-arch/tar
	app-arch/bzip2"
RDEPEND=">=app-shells/bash-2.05a"

S="${WORKDIR}/${PN/-/_}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo.diff
}

src_install() {
	insinto /etc
	doins bash_completion || die "failed to install bash_completion"
	exeinto /etc/profile.d
	doexe ${FILESDIR}/bash-completion || die "failed to install profile.d"

	# >=dev-util/subversion-1.1.1-r3 provides extremely superior completions
	has_version ">=dev-util/subversion-1.1.1-r3" && rm contrib/subversion
	insinto /usr/share/bash-completion
	doins contrib/* || die "failed to install contrib completions"

	dodoc Changelog README

	# gentoo-bashcomp
	cd ${WORKDIR}/gentoo-bashcomp-${GENCOMP_VERS}
	doins src/gentoo || die "failed to install gentoo completions"
	dodir /etc/bash_completion.d
	dosym ../../usr/share/bash-completion/gentoo /etc/bash_completion.d/gentoo \
		|| die "dosym gentoo-bashcomp failed"
	docinto gentoo
	dodoc AUTHORS NEWS TODO
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
}
