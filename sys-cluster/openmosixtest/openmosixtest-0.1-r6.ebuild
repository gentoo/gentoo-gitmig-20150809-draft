# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmosixtest/openmosixtest-0.1-r6.ebuild,v 1.1 2004/03/28 10:01:23 tantive Exp $

S=${WORKDIR}/omtest
DESCRIPTION="openMosix stress test"
SRC_URI="www.openmosixview.com/omtest/omtest-${PV}-4.1.tar.gz
		http://www.openmosixview.com/omtest/portfolio04.tgz
		http://belnet.dl.sourceforge.net/sourceforge/ltp/ltp-full-20040304.tgz
		ftp://ftp.bitmover.com/lmbench/lmbench-2.0.4.tgz"
HOMEPAGE="http://www.openmosixview.com/omtest/"
IUSE=""

DEPEND=">=dev-libs/openssl-0.6.9g
	>=dev-lang/perl-5.6.1
	>=dev-perl/Parallel-ForkManager-0.7.4
	>=dev-perl/Statistics-Descriptive-Discrete-0.07
	>=sys-cluster/openmosix-user-0.2.4
	>=sys-kernel/openmosix-sources-2.4.18"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~x86"


src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/portfolio04.pl ${S}/portfolio/portfolio.pl
	rm -rf ${S}/ltp
	mv ${WORKDIR}/ltp-full-20040304 ${S}/ltp
	rm -rf ${S}/lmbench
	mv ${WORKDIR}/lmbench-2.0.4 ${S}/lmbench
	cp ${FILESDIR}/compile.ltp.sh ${S}/ltp/compile.sh
	cp ${FILESDIR}/compile.lmbench.sh ${S}/lmbench/compile.sh
	cd ${S}

	#Make compile_tests.sh non-interactive and cut "make install" for perl module"
	mv compile_tests.sh compile_tests.sh.orig
	sed -e 's:read::' compile_tests.sh.orig >compile_tests.sh.orig2
	sed -e 's:make install::' compile_tests.sh.orig2 >compile_tests.sh
	rm compile_tests.sh.orig compile_tests.sh.orig2
	chmod +x compile_tests.sh
}

src_compile() {
	./compile_tests.sh
	rm -rf required
}

src_install() {
	dodir /opt/omtest
	cp -r * ${WORKDIR}/../image/opt/omtest
	dodir /usr/bin
	dobin start_openMosix_test.sh
	fperms 755 /usr/bin/start_openMosix_test.sh
	keepdir /opt/omtest/lmbench/BitKeeper/tmp
}

pkg_postinst() {
	einfo
	einfo "openMosix stress test is now installed in /opt/omtest"
	einfo "You can run it by executing start_openMosix_test.sh"
	einfo
}
