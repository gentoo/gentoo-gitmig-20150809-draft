# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/pybugz/pybugz-9999.ebuild,v 1.2 2011/02/18 00:21:00 williamh Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
PYTHON_DEPEND="2:2.5"
PYTHON_MODNAME="bugz"
PYTHON_USE_WITH="readline"

inherit bash-completion distutils

if [[ ${PV} == "9999" ]] ; then
EGIT_REPO_URI="git://github.com/williamh/pybugz.git"
KEYWORDS=""
inherit git
else
SRC_URI="http://pybugz.googlecode.com/files/${P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
fi

DESCRIPTION="Command line interface to (Gentoo) Bugzilla"
HOMEPAGE="http://www.liquidx.net/pybugz"
LICENSE="GPL-2"
SLOT="0"
IUSE="zsh-completion"

RDEPEND="${DEPEND}
|| ( dev-lang/python:2.7 dev-python/argparse )
	zsh-completion? ( app-shells/zsh )"

src_install() {
	distutils_src_install

doman man/bugz.1
	dobashcompletion contrib/bash-completion bugz

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins contrib/zsh-completion _pybugz
	fi
}
