# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/systemc/systemc-2.2.0-r1.ebuild,v 1.1 2009/07/11 17:59:04 calchan Exp $

inherit versionator multilib

DESCRIPTION="A C++ based modeling platform for VLSI and system-level co-design"
LICENSE="SOPLA-2.3"
HOMEPAGE="http://www.systemc.org/"
SRC_URI="${P}.tgz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"
RESTRICT="fetch test"

DEPEND=""
RDEPEND=""

pkg_nofetch() {
	elog "${PN} developers require end-users to accept their license agreement"
	elog "by registering on their Web site (${HOMEPAGE})."
	elog "Please download ${A} manually and place it in ${DISTDIR}."
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:lib-\$(TARGET_ARCH):$(get_libdir):g" $(find . -name Makefile.in) || die "Patching Makefile.in failed"

	sed -i -e "s:OPT_CXXFLAGS=\"-O3\":OPT_CXXFLAGS=\"${CXXFLAGS}\":g" configure || die "Patching configure failed"

	sed -i -e '/#include "sysc\/utils\/sc_report.h"/a \
#include <cstdlib> \
#include <cstring>' src/sysc/utils/sc_utils_ids.cpp  || die "Patching failed"

	for sfile in src/sysc/qt/md/*.s ; do
		sed -i -e '$a \
#if defined(__linux__) && defined(__ELF__) \
.section .note.GNU-stack,"",%progbits \
#endif' "${sfile}" || die "Patching ${sfile} failed"
	done
}

src_compile() {
	econf --disable-dependency-tracking CXX="g++" || die "Configuration failed"
	cd src
	emake || die "Compilation failed"
}

src_install() {
	dodoc AUTHORS ChangeLog INSTALL NEWS README RELEASENOTES
	insinto /usr/share/doc/${PF}/docs
	doins docs/*
	cd src
	einstall
}

pkg_postinst() {
	elog "If you want to run the examples, you need to :"
	elog "    tar xvfz ${PORTAGE_ACTUAL_DISTDIR}/${A}"
	elog "    cd ${P}"
	elog "    find examples -name 'Makefile.*' -exec sed -i -e 's/-lm/-lm -lpthread/' '{}' \;"
	elog "    ./configure"
	elog "    cd examples"
	elog "    make check"
}
