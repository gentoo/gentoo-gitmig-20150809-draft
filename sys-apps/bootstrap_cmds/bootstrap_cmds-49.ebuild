# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bootstrap_cmds/bootstrap_cmds-49.ebuild,v 1.1 2005/05/19 20:10:20 kito Exp $

DESCRIPTION="Darwin bootstrap_cmds - config, decomment, mig, relpath"
HOMEPAGE="http://darwinsource.opendarwin.org/10.3.5/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/${P}.tar.gz"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE="build"
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e 's:^NEXTSTEP_BUILD_OUTPUT_DIR = .*:NEXTSTEP_BUILD_OUTPUT_DIR = ${T}:' Makefile

	cd ${S}/config.tproj
	sed -i -e '/raise/d' config.h

	cd ${S}/decomment.tproj
	sed -i \
		-e 's:^NEXTSTEP_INSTALLDIR = .*:NEXTSTEP_INSTALLDIR = /usr/bin:' \
		-e 's:^NEXTSTEP_BUILD_OUTPUT_DIR = .*:NEXTSTEP_BUILD_OUTPUT_DIR = ${T}:' Makefile

	cd ${S}/relpath.tproj
	sed -i \
		-e 's:^NEXTSTEP_INSTALLDIR = .*:NEXTSTEP_INSTALLDIR = /usr/bin:' \
		-e 's:^NEXTSTEP_BUILD_OUTPUT_DIR = .*:NEXTSTEP_BUILD_OUTPUT_DIR = ${T}:' Makefile
	cd ${S}
	rm Makefile.postamble config.tproj/Makefile.postamble decomment.tproj/Makefile.postamble \
	relpath.tproj/Makefile.postamble
}

src_compile() {
	:
}

src_install() {
	make install DSTROOT=${D} || die "make install failed"

	newbin vers_string.sh vers_string
	use build || doman *.1
}
