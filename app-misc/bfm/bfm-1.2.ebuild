# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bfm/bfm-1.2.ebuild,v 1.2 2005/04/02 10:02:14 axxo Exp $

inherit java-pkg

DESCRIPTION="File manager and first person shooter written in Java3D, you remove files by shooting at them"
HOMEPAGE="http://bfm.webhop.net"
SRC_URI="http://bfm.webhop.net/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jre-1.4
	|| ( >=dev-java/blackdown-java3d-bin-1.3.1-r1
		>=dev-java/sun-java3d-bin-1.3 )
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}

	cd ${S}
	cp ${FILESDIR}/${PV}-build.xml ./build.xml

	mkdir ${S}/lib && cd ${S}/lib
	if has_version sun-java3d-bin; then
		java-pkg_jar-from sun-java3d-bin
	elif has_version blackdown-java3d-bin; then
		java-pkg_jar-from blackdown-java3d-bin
	fi
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	local java3d=""
	if has_version blackdown-java3d-bin; then
		java3d="blackdown-java3d-bin"
	elif has_version sun-java3d-bin; then
		java3d="sun-java3d-bin"
	fi

	echo "#!/bin/sh" > ${PN}
	echo "\$(java-config -J) -Djava.library.path=\$(java-config -i ${java3d}) -cp \$(java-config -p bfm,${java3d}) Bfm"  \"\$@\">> ${PN}

	dobin ${PN}

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
