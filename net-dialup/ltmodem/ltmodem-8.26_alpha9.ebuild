# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ltmodem/ltmodem-8.26_alpha9.ebuild,v 1.1 2003/01/10 02:31:18 vapier Exp $

MY_P="${P/_alpha/a}"
DESCRIPTION="Winmodems with Lucent Apollo (ISA) and Mars (PCI) chipsets"
HOMEPAGE="http://www.heby.de/ltmodem/"
SRC_URI="http://www.physcip.uni-stuttgart.de/heby/ltmodem/${MY_P}.tar.gz
	http://www.sfu.ca/~cth/ltmodem/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

S="${WORKDIR}/${MY_P}"

src_compile() {
	cp build_module{,.orig}
	sed -e 's:read -p:echo:' build_module.orig > build_module
	./build_module ${KV} >& ${T}/build_module-report
	cd source
	make || die "please include ${T}/build_module-report in any bug report"
}

src_install() {
	dohtml DOCs/*.html
	rm -rf DOCs/*.html DOCs/Installers

	dodoc 1ST-READ BLDrecord.txt Utility_version_tests.txt DOCs/*

	mv utils/fixscript utils/ltfixscript
	mv utils/noisefix utils/ltnoisefix
	mv utils/unloading utils/ltunloading
	dobin utils/lt*

	cd source
	make install ROOTDIR=${D} || die
}

pkg_postinst() {
	einfo "To get going real fast read this doc:"
	einfo "/usr/share/doc/${PF}/html/post-install.html"
}
