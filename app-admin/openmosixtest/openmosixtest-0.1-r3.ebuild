# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/openmosixtest/openmosixtest-0.1-r3.ebuild,v 1.1 2002/11/07 16:01:52 tantive Exp $

S=${WORKDIR}/omtest
DESCRIPTION="openMosix stress test"
SRC_URI="www.openmosixview.com/omtest/omtest-${PV}-`echo ${PR}|sed -e 's:r\([0-9]\+\):\1:'`.tar.gz"
HOMEPAGE="http://www.openmosixview.com/omtest/"
IUSE=""

DEPEND=">=dev-libs/openssl-0.6.9g
	>=sys-devel/perl-5.6.1
	>=sys-cluster/openmosix-user-0.2.4
	>=sys-kernel/openmosix-sources-2.4.18"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -sparc64 -alpha"

src_install() {
	dodir /opt/omtest
	cp -r * ${WORKDIR}/../image/opt/omtest
}


pkg_postinst() {
	cd /opt/omtest
	einfo
	einfo "The openMosix stress test installation will be completed right now."
	einfo
	./compile_tests.sh
	
	einfo
	einfo "openMosix stress test is now installed in /opt/omtest"
	einfo "You can run it by executing start_openMosix_test.sh"
	einfo
}
