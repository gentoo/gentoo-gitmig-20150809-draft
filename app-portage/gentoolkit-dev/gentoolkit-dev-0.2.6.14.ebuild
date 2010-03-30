# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit-dev/gentoolkit-dev-0.2.6.14.ebuild,v 1.1 2010/03/30 13:54:05 idl0r Exp $

EAPI="2"
PYTHON_DEPEND="*:2.6:3.1"
PYTHON_USE_WITH="xml"

inherit python

DESCRIPTION="Collection of developer scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/portage
	dev-lang/perl"

src_test() {
	# echangelog test is not able to run as root
	# the EUID check may not work for everybody
	if [[ ${EUID} -ne 0 ]];
	then
		emake test || die
	else
		ewarn "test skipped, please re-run as non-root if you wish to test ${PN}"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
}
