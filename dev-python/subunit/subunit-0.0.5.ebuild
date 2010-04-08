# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/subunit/subunit-0.0.5.ebuild,v 1.1 2010/04/08 07:39:25 fauli Exp $

PYTHON_DEPEND="2:2.6"

inherit python

DESCRIPTION="A streaming protocol for test results"
HOMEPAGE="https://launchpad.net/subunit"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-python/testtools
	dev-util/cppunit
	dev-lang/perl
	dev-util/pkgconfig"
RDEPEND=""

pkg_setup() {
	python_set_active_version 2
}

src_install() {
	emake install DESTDIR="${D}"|| die
}
