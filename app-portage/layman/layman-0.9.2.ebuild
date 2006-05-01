# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/layman/layman-0.9.2.ebuild,v 1.2 2006/05/01 19:52:16 wrobel Exp $

inherit eutils distutils

DESCRIPTION="A python script for retrieving gentoo overlays "
HOMEPAGE="http://projects.gunnarwrobel.de/scripts"
SRC_URI="http://dev.gentoo.org/~wrobel/layman/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ia64 ~x86"
IUSE=""
S=${WORKDIR}/${PF}

DEPEND="dev-util/subversion"

src_install() {

	distutils_src_install

	dodir /etc/layman
	cp etc/* ${D}/etc/layman/

	doman doc/layman.8
	dohtml doc/layman.8.html

}

src_test() {
	cd ${S}
	einfo "Running layman doctests... [Testing requires an internet connection!]"
	echo
	if ! PYTHONPATH="." ${python} layman/tests/dtest.py; then
		eerror "DocTests failed - please submit a bug report"
		die "DocTesting failed!"
	fi
}

pkg_postinst() {
	einfo "If you emerged layman for the first time, you should update your local list"
	einfo "of available overlays first. Run "
	echo
	einfo "layman -f"
	echo
	einfo "in order to do that."
	echo
	einfo "You are then ready to add overlays into your system."
	echo
	einfo "layman -L"
	echo
	einfo "will display a list of available overlays."
	echo
	einfo "Select one and add it using"
	echo
	einfo "layman -a overlay-name"
	echo
	einfo "If this is the very first overlay you add with layman, you need to append"
	einfo "the following statement to your /etc/make.conf file:"
	echo
	einfo "source /usr/portage/local/layman/make.conf"
	echo
	epause 5
}
