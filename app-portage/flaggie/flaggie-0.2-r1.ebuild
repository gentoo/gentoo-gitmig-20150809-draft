# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/flaggie/flaggie-0.2-r1.ebuild,v 1.1 2012/08/31 09:13:52 mgorny Exp $

EAPI=4
PYTHON_COMPAT='python2_6 python2_7 python3_1 python3_2'

inherit base bash-completion-r1 python-distutils-ng

DESCRIPTION="A smart CLI mangler for package.* files"
HOMEPAGE="https://bitbucket.org/mgorny/flaggie/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=sys-apps/portage-2.1.8.3"

python_prepare_all() {
	base_src_prepare
}

python_install_all() {
	dodoc README
	newbashcomp contrib/bash-completion/${PN}.bash-completion ${PN}
}

pkg_postinst() {
	ewarn "Please denote that flaggie creates backups of your package.* files"
	ewarn "before performing each change through appending a single '~'."
	ewarn "If you'd like to keep your own backup of them, please use another"
	ewarn "naming scheme (or even better some VCS)."
	elog
	elog "bash-completion support requires:"
	elog "	app-shells/gentoo-bashcomp"
	has_version app-shells/gentoo-bashcomp && \
		elog "(installed already)"
}
