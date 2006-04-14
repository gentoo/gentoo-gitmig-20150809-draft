# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/layman/layman-0.9.1.ebuild,v 1.1 2006/04/14 07:23:03 wrobel Exp $

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
	einfo "Running layman doctests..."
	if ! PYTHONPATH="." ${python} layman/tests/dtest.py; then
		eerror "DocTests failed - please submit a bug report"
		die "DocTesting failed!"
	fi
}

pkg_postinst() {
	echo
	einfo "Now that you have emerged layman, you need to append the following"
	einfo "statement to your /etc/make.conf file:"
	echo
	einfo "source /usr/portage/local/layman/make.conf"
	echo
	einfo "Run "
	echo
	einfo "layman -f"
	echo
	einfo "after that."
	echo
	epause 5
}
