# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcalc/kcalc-4.0.0.ebuild,v 1.1 2008/01/17 23:35:42 philantrop Exp $

EAPI="1"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="KDE calculator"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook test"

COMMONDEPEND="dev-libs/gmp"
DEPEND="${DEPEND} ${COMMONDEPEND}"
RDEPEND="${RDEPEND} ${COMMONDEPEND}"

src_test() {
	pushd "${WORKDIR}"/${PN}_build/kcalc/knumber/tests > /dev/null
	emake knumbertest && \
		./knumbertest.shell || die "Tests failed."
	popd > /dev/null
}
