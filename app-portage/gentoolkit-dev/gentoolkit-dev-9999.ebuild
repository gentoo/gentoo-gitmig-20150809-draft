# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit-dev/gentoolkit-dev-9999.ebuild,v 1.12 2014/11/18 08:43:26 mgorny Exp $

EAPI="5"
PYTHON_DEPEND="*:2.6"
PYTHON_USE_WITH="xml"

inherit git-r3 python

DESCRIPTION="Collection of developer scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI=""
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/gentoolkit.git
	http://git.overlays.gentoo.org/gitroot/proj/gentoolkit.git"
EGIT_BRANCH="gentoolkit-dev"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="sys-apps/portage
	dev-lang/perl
	sys-apps/diffutils"

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
	emake DESTDIR="${ED}" VERSION="${PV}" install || die
}
