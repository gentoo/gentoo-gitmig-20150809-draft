# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/pybugz/pybugz-0.8.0_rc3.ebuild,v 1.1 2009/08/12 20:42:37 williamh Exp $

EAPI="2"

inherit bash-completion distutils

DESCRIPTION="Command line interface to (Gentoo) Bugzilla"
HOMEPAGE="http://www.liquidx.net/pybugz"
SRC_URI="http://pybugz.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="zsh-completion"
DEPEND="|| ( >=dev-lang/python-2.5[readline]
	( >=dev-lang/python-2.4[readline]
		dev-python/elementtree ) )"
RDEPEND="${DEPEND}
	bash-completion? ( app-shells/bash )
	zsh-completion? ( app-shells/zsh )"

src_install() {
	distutils_src_install

	if use bash-completion; then
		dobashcompletion contrib/bash-completion bugz
	fi

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins contrib/zsh-completion _pybugz
	fi
}
