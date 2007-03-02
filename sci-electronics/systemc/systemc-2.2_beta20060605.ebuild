# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/systemc/systemc-2.2_beta20060605.ebuild,v 1.1 2007/03/02 20:13:41 calchan Exp $

inherit versionator multilib

SNAPSHOTDATE="05jun06"
MY_PV="$(get_version_component_range 1-2).${SNAPSHOTDATE}"

DESCRIPTION="A C++ based modeling platform for VLSI and system-level co-design"
LICENSE="SOPLA-2.3"
HOMEPAGE="http://www.systemc.org/"
SRC_URI="${PN}-${MY_PV}.tgz"

SLOT="0"
IUSE=""
KEYWORDS="~x86"
RESTRICT="fetch test"

DEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}_beta"

pkg_nofetch() {
	elog "${PN} developers require end-users to accept their license agreement"
	elog "by registering on their Web site (${HOMEPAGE})."
	elog "Please download ${A} manually and place it in ${DISTDIR}."
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:lib-\$(TARGET_ARCH):$(get_libdir):g" $(find . -name Makefile.in) || die "Patching failed"
	sed -i -e "s:OPT_CXXFLAGS=\"-O3\":OPT_CXXFLAGS=\"${CXXFLAGS}\":g" configure || die "Patching failed"
}

src_compile() {
	econf --disable-dependency-tracking CXX="g++" || die "Configuration failed"
	cd src
	emake || die "Compilation failed"
}

src_install() {
	dodoc AUTHORS ChangeLog INSTALL NEWS README RELEASENOTES
	insinto /usr/share/doc/${PF}/docs
	doins doc/*
	cd src
	einstall
}

pkg_postinst() {
	elog "If you want to run the examples, you need to :"
	elog "    tar xvfz ${PORTAGE_ACTUAL_DISTDIR}/${A}"
	elog "    cd ${PN}-${MY_PV}_beta"
	elog "    ./configure"
	elog "    cd examples"
	elog "    make check"
}
