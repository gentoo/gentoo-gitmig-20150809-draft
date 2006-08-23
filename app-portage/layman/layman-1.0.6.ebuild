# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/layman/layman-1.0.6.ebuild,v 1.5 2006/08/23 00:11:34 wormo Exp $

inherit eutils distutils

DESCRIPTION="A python script for retrieving gentoo overlays "
HOMEPAGE="http://projects.gunnarwrobel.de/scripts"
SRC_URI="http://build.pardus.de/downloads/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ia64 ppc ~sparc x86"
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
	echo
	if ! PYTHONPATH="." ${python} layman/tests/dtest.py; then
		eerror "DocTests failed - please submit a bug report"
		die "DocTesting failed!"
	fi
}

pkg_postinst() {
	einfo "You are now ready to add overlays into your system."
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
