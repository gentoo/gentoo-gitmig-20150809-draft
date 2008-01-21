# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qmtest/qmtest-2.4.ebuild,v 1.1 2008/01/21 19:54:35 kanaka Exp $

inherit eutils
DESCRIPTION="CodeSourcery's test harness system"
HOMEPAGE="http://www.codesourcery.com/qmtest/"
SRC_URI="http://www.codesourcery.com/public/${PN}/${PF}/${PF}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python"

src_compile() {
	python setup.py build || die "setup.py build failed"
}

src_install() {
	python setup.py install --root ${D} \
		|| die "setup.py install failed"

	sed -i "s@${D}@/usr@" ${D}/usr/lib*/python2.4/site-packages/qm/config.py \
		|| die "Could not adjust install path in config.py"
}
