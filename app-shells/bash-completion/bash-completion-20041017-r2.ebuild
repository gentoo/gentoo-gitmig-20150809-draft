# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20041017-r2.ebuild,v 1.1 2004/11/27 09:42:59 ka0ttic Exp $

inherit eutils

GENCOMP_VERS="1.0_beta3"

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

S=${WORKDIR}/${PN/-/_}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo.diff
}

src_install() {
	insinto /etc
	doins bash_completion

	# >=dev-util/subversion-1.1.1-r3 provides extremely superior completions
	has_version ">=dev-util/subversion-1.1.1-r3" && rm contrib/subversion

	insinto /usr/share/bash-completion
	doins contrib/*

	exeinto /etc/profile.d
	doexe ${FILESDIR}/bash-completion

	dodoc Changelog README

	cd ${WORKDIR}/gentoo-bashcomp-${GENCOMP_VERS}
	insinto /etc/bash_completion.d
	doins src/gentoo

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

	if [ -f ${ROOT}/etc/bash_completion.d/gentoo.completion ]
	then
		echo
		ewarn "The file 'gentoo.completion' in '/etc/bash_completion.d/' has been"
		ewarn "replaced with 'gentoo'. Remove gentoo.completion to avoid problems."
	fi

	local bcfile moved
	for bcfile in ${ROOT}/etc/bash_completion.d/{unrar,harbour,isql,larch,lilypond,p4,ri}
	do

		[ -f "${bcfile}" -a ! -L "${bcfile}" ] && moved="${bcfile##*/} ${moved}"
	done

	if [ -n "${moved}" ]
	then
		echo
		ewarn "The contrib files: ${moved}"
		ewarn "have been moved to /usr/share/bash-completion. Please DELETE"
		ewarn "those old files in /etc/bash_completion.d and create symlinks."
	fi
	echo
}
