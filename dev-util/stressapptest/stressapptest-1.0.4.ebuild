# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/stressapptest/stressapptest-1.0.4.ebuild,v 1.3 2012/12/19 21:32:13 vapier Exp $

EAPI="4"

MY_P="${P}_autoconf"
DESCRIPTION="Stressful Application Test"
HOMEPAGE="http://code.google.com/p/stressapptest/"
SRC_URI="http://stressapptest.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug"

RDEPEND="dev-libs/libaio"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i \
		'/CXXFLAGS/s:-O3 -funroll-all-loops  -funroll-loops::' \
		configure || die
}

src_install() {
	default
	doman "${ED}"/usr/share/doc/${PN}/${PN}.1
	rm -rf "${ED}"/usr/share/doc # only installs COPYING & man page
}
