# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/openmosixtest/openmosixtest-0.1-r5.ebuild,v 1.1 2003/05/22 12:19:33 tantive Exp $

S=${WORKDIR}/omtest
DESCRIPTION="openMosix stress test"
SRC_URI="www.openmosixview.com/omtest/omtest-${PV}-4.1.tar.gz"
#SRC_URI="www.openmosixview.com/omtest/omtest-${PV}-`echo ${PR}|sed -e 's:r\([0-9]\+\):\1:'`.tar.gz"
HOMEPAGE="http://www.openmosixview.com/omtest/"
IUSE=""

DEPEND=">=dev-libs/openssl-0.6.9g
	>=dev-lang/perl-5.6.1
	>=sys-cluster/openmosix-user-0.2.4
	>=sys-kernel/openmosix-sources-2.4.18"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc  -alpha"


src_unpack() {
	unpack ${A}
	cd ${S}

	#Make compile_tests.sh non-interactive
	mv compile_tests.sh compile_tests.sh.orig
	sed -e 's:read::' compile_tests.sh.orig >compile_tests.sh
	rm compile_tests.sh.orig
	chmod +x compile_tests.sh
}

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
