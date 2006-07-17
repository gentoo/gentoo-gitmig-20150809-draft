# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bfm/bfm-1.2-r1.ebuild,v 1.1 2006/07/17 15:16:39 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="File manager and first person shooter written in Java3D, you remove files by shooting at them"
HOMEPAGE="http://bfm.webhop.net"
SRC_URI="http://bfm.webhop.net/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.4
	|| ( >=dev-java/blackdown-java3d-bin-1.3.1-r1
		>=dev-java/sun-java3d-bin-1.3 )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core
	source? ( app-arch/zip )"

ant_src_unpack() {
	unpack ${A}

	cd ${S}
	cp ${FILESDIR}/${PV}-build.xml ./build.xml

	mkdir ${S}/lib && cd ${S}/lib
	if has_version dev-java/sun-java3d-bin; then
		java-pkg_jar-from sun-java3d-bin
	elif has_version dev-java/blackdown-java3d-bin; then
		java-pkg_jar-from blackdown-java3d-bin
	fi
}

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	local java3d=""
	if has_version dev-java/blackdown-java3d-bin; then
		java3d="blackdown-java3d-bin"
	elif has_version dev-java/sun-java3d-bin; then
		java3d="sun-java3d-bin"
	fi

	java-pkg_dolauncher ${PN} --main Bfm

	insinto /etc/bfm
	doins ${S}/bfm.conf

	if use doc; then
		dodoc README ChangeLog bindings NEWS
		java-pkg_dohtml -r docs/*
	fi
	use source && java-pkg_dosrc src/*
}

pkg_postinst() {
	einfo ""
	einfo "Bfm - The Brutal File Manager has been successfully installed!"
	einfo ""
	einfo "A system wide config file has been installed to /etc/bfm/bfm.conf"
	einfo "Copy the file to ~/.bfm/bfm.conf to set local settings"
	einfo ""
	ewarn ""
	ewarn "Be sure to run bfm in safe mode if you don't want to delete files"
	ewarn ""
}
