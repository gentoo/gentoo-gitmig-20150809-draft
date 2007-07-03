# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyode/pyode-1.1.0_p20060728.ebuild,v 1.4 2007/07/03 07:29:10 lucass Exp $

inherit distutils

DESCRIPTION="Python bindings to the ODE physics engine"
HOMEPAGE="http://pyode.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-games/ode-0.5
	>=dev-python/pyrex-0.9.4.1"

S="$WORKDIR/${PN}"

src_unpack() {
	unpack ${A}
	cp "${FILESDIR}"/setup.py "${S}"
}

src_install() {
	distutils_src_install
	# The build system doesnt error if it fails to build
	# the ode library so we need our own sanity check
	[[ -z $(find "${D}" -name ode.so) ]] && die "failed to build/install :("
}
