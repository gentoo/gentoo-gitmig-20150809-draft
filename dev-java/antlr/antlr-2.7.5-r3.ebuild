# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-2.7.5-r3.ebuild,v 1.1 2006/07/23 16:08:43 nichoj Exp $

inherit gnuconfig java-pkg-2 mono distutils multilib

DESCRIPTION="A parser generator for C++, C#, Java, and Python"
HOMEPAGE="http://www.antlr.org/"
SRC_URI="http://www.antlr.org/download/${P}.tar.gz"

LICENSE="ANTLR"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doc debug examples mono nocxx nojava python script source"

RDEPEND=">=virtual/jdk-1.2
	dev-java/java-config
	mono? ( dev-lang/mono dev-util/pkgconfig )
	python? ( dev-lang/python )"
DEPEND="${RDEPEND}
	script? ( !dev-util/pccts )
	>=sys-apps/sed-4
	sys-apps/findutils
	source? ( app-arch/zip )"

src_compile() {
	gnuconfig_update

	export JAVAC=javac

	export JAVACFLAGS="+ ${JAVACFLAGS}"

	econf $(use_enable !nojava java) \
		  $(use_enable python) \
		  $(use_enable mono csharp) \
		  $(use_enable debug) \
		  $(use_enable examples) \
		  $(use_enable !nocxx cxx) \
		  --enable-verbose || die "configure failed"

	emake || die "compile failed"

	sed -e "s|@prefix@|/usr/|" \
		-e 's|@exec_prefix@|${prefix}|' \
		-e "s|@libdir@|\$\{exec_prefix\}/$(get_libdir)/antlr|" \
		-e 's|@libs@|-r:\$\{libdir\}/antlr.astframe.dll -r:\$\{libdir\}/antlr.runtime.dll|' \
		-e "s|@VERSION@|${PV}|" \
		${FILESDIR}/antlr.pc.in > ${S}/antlr.pc

	if ! use nojava && use script ; then
		cat > antlr.sh <<-EOF
		#!/bin/sh
		ANTLR_JAR=\$(java-config -p antlr)
		\$(java-config -J) -cp \$ANTLR_JAR antlr.Tool \$*
		EOF
	fi
}

src_install() {
	exeinto /usr/bin
	doexe ${S}/scripts/antlr-config

	if ! use nocxx ; then
		cd ${S}/lib/cpp
		einstall || die "failed to install C++ files"
	fi

	if ! use nojava ; then
		exeinto /usr/bin
		use script && newexe ${S}/antlr.sh antlr

		java-pkg_dojar ${S}/antlr/antlr.jar

		use source && java-pkg_dosrc ${S}/antlr
		use doc && java-pkg_dohtml -r doc/*
	fi

	if use mono ; then
		cd ${S}/lib

		dodir /usr/$(get_libdir)/antlr/
		insinto /usr/$(get_libdir)/antlr/

		doins antlr.astframe.dll
		doins antlr.runtime.dll

		insinto /usr/$(get_libdir)/pkgconfig
		doins ${S}/antlr.pc
	fi

	if use python ; then
		cd ${S}/lib/python
		distutils_src_install
	fi

	if use examples ; then
		find ${S}/examples -iname Makefile\* -exec rm \{\} \;

		dodir /usr/share/doc/${PF}/examples
		insinto /usr/share/doc/${PF}/examples

		! use cxx && doins -r ${S}/examples/cpp
		use java && doins -r ${S}/examples/java
		use mono && doins -r ${S}/examples/csharp
		use python && doins -r ${S}/examples/python
	fi

	newdoc ${S}/README.txt README
}
