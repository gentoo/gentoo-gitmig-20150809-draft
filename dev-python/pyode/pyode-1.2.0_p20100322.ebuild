# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyode/pyode-1.2.0_p20100322.ebuild,v 1.1 2010/12/25 13:40:29 nelchael Exp $

inherit distutils

MY_P=${P/pyode/PyODE}
SNAPSHOT_DATE="2010-03-22"	# This is a snapshot

DESCRIPTION="Python bindings to the ODE physics engine"
HOMEPAGE="http://pyode.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/PyODE-snapshot-${SNAPSHOT_DATE}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=dev-games/ode-0.7
	>=dev-python/pyrex-0.9.4.1"
DEPEND="${RDEPEND}"

S="${WORKDIR}/PyODE-snapshot-${SNAPSHOT_DATE}"

src_install() {
	distutils_src_install
	# The build system doesnt error if it fails to build
	# the ode library so we need our own sanity check
	[[ -z $(find "${D}" -name ode.so) ]] && die "failed to build/install :("

	if use examples; then
		insinto "/usr/share/doc/${PF}"
		doins -r examples
	fi
}
