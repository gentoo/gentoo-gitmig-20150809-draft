# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion/bash-completion-20040704.ebuild,v 1.2 2004/10/31 01:33:14 vapier Exp $

GENCOMP_VERS="1.0_beta"

DESCRIPTION="Programmable Completion for bash (includes emerge and ebuild commands)"
HOMEPAGE="http://www.caliban.org/bash/index.shtml#completion"
SRC_URI="http://www.caliban.org/files/bash/${P}.tar.bz2
	mirror://sourceforge/gentoo-bashcomp/gentoo-bashcomp-${GENCOMP_VERS}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~s390 ~sparc ~x86"
IUSE=""

DEPEND="app-arch/tar
	app-arch/bzip2"
RDEPEND=">=app-shells/bash-2.05a"

S=${WORKDIR}/${PN/-/_}

src_install() {
	insinto /etc
	doins bash_completion

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
	einfo "[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion"
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
