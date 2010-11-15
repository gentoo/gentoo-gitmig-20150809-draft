# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/pybugz/pybugz-0.8.0.ebuild,v 1.12 2010/11/15 15:50:59 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="readline"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
PYTHON_MODNAME="bugz"

inherit bash-completion distutils

DESCRIPTION="Command line interface to (Gentoo) Bugzilla"
HOMEPAGE="http://www.liquidx.net/pybugz"
SRC_URI="http://pybugz.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="zsh-completion"

DEPEND=""
RDEPEND="zsh-completion? ( app-shells/zsh )"

src_install() {
	distutils_src_install

	dobashcompletion contrib/bash-completion bugz

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins contrib/zsh-completion _pybugz
	fi
}
