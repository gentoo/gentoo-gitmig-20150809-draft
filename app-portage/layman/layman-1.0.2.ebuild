# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/layman/layman-1.0.2.ebuild,v 1.3 2006/06/05 08:29:24 wrobel Exp $

inherit eutils distutils

DESCRIPTION="A python script for retrieving gentoo overlays "
HOMEPAGE="http://projects.gunnarwrobel.de/scripts"
SRC_URI="http://dev.gentoo.org/~wrobel/layman/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
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
	einfo
	einfo "layman -f"
	einfo
	einfo "in order to do that."
	einfo
	einfo "You are then ready to add overlays into your system."
	einfo
	einfo "layman -L"
	einfo
	einfo "will display a list of available overlays."
	einfo
	einfo "Select one and add it using"
	einfo
	einfo "layman -a overlay-name"
	einfo
	einfo "If this is the very first overlay you add with layman, you need to append"
	einfo "the following statement to your /etc/make.conf file:"
	einfo
	einfo "source /usr/portage/local/layman/make.conf"
	einfo
	epause 5
}
