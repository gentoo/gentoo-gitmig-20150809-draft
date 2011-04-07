# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyode/pyode-1.2.0.ebuild,v 1.6 2011/04/07 16:40:18 arfrever Exp $

EAPI="3"

inherit distutils

MY_P=${P/pyode/PyODE}
DESCRIPTION="Python bindings to the ODE physics engine"
HOMEPAGE="http://pyode.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyode/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="examples"

DEPEND=">=dev-games/ode-0.7
	>=dev-python/pyrex-0.9.4.1"

S="$WORKDIR/${MY_P}"

src_install() {
	distutils_src_install
	# The build system doesnt error if it fails to build
	# the ode library so we need our own sanity check
	[[ -z $(find "${D}" -name ode.so) ]] && die "failed to build/install :("

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
