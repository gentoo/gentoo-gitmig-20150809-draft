# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/patchutils/patchutils-0.3.0.ebuild,v 1.7 2008/12/17 20:20:10 maekke Exp $

DESCRIPTION="A collection of tools that operate on patch files"
HOMEPAGE="http://cyberelk.net/tim/patchutils/"
SRC_URI="http://cyberelk.net/tim/data/patchutils/stable/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="test"

RDEPEND=""
# The testsuite makes use of gendiff(1) that comes from rpm, thus if
# the user wants to run tests, it should install that too.
DEPEND="test? ( app-arch/rpm )"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO || die "dodoc failed"
}
