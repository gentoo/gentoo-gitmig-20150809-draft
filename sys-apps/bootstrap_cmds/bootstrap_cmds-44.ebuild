# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bootstrap_cmds/bootstrap_cmds-44.ebuild,v 1.6 2004/10/08 03:04:51 kito Exp $

DESCRIPTION="Darwin bootstrap_cmds - config, decomment, mig, relpath"
HOMEPAGE="http://darwinsource.opendarwin.org/10.3.5/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/${P}.tar.gz"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE=""
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e 's:^NEXTSTEP_BUILD_OUTPUT_DIR = .*:NEXTSTEP_BUILD_OUTPUT_DIR = ${T}:' Makefile

	cd ${S}/decomment.tproj
	sed -i -e 's:^NEXTSTEP_INSTALLDIR = .*:NEXTSTEP_INSTALLDIR = /usr/bin:' Makefile
	sed -i -e 's:^NEXTSTEP_BUILD_OUTPUT_DIR = .*:NEXTSTEP_BUILD_OUTPUT_DIR = ${T}:' Makefile

	cd ${S}/relpath.tproj
	sed -i -e 's:^NEXTSTEP_INSTALLDIR = .*:NEXTSTEP_INSTALLDIR = /usr/bin:' Makefile
	sed -i -e 's:^NEXTSTEP_BUILD_OUTPUT_DIR = .*:NEXTSTEP_BUILD_OUTPUT_DIR = ${T}:' Makefile

	rm ${S}/Makefile.postamble
	rm ${S}/config.tproj/Makefile.postamble
	rm ${S}/decomment.tproj/Makefile.postamble
	rm ${S}/relpath.tproj/Makefile.postamble
}

src_install() {
	make install DSTROOT=${D} || die "make install failed"

	newbin vers_string.sh vers_string
	doman *.1
}