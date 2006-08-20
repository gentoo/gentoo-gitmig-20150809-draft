# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.3.0.ebuild,v 1.3 2006/08/20 20:32:19 wormo Exp $

PHP_EXT_NAME="php_ming"
inherit eutils toolchain-funcs java-pkg perl-module php-ext-source-r1 python distutils

DESCRIPTION="An Open Source library for flash movie generation"
HOMEPAGE="http://ming.sourceforge.net/"
SRC_URI="mirror://sourceforge/ming/${P}.tar.gz
	java? ( mirror://sourceforge/ming/${PN}-java-${PV}.tar.gz )
	perl? ( mirror://sourceforge/ming/${PN}-perl-${PV}.tar.gz )
	php? ( mirror://sourceforge/ming/${PN}-php-${PV}.tar.gz )
	python? ( mirror://sourceforge/ming/${PN}-py-${PV}.tar.gz )"

IUSE="java perl php python"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86"

DEPEND="${RDEPEND}
	sys-devel/flex
	java? ( virtual/jdk
		dev-java/java-config )"

RDEPEND="java? ( virtual/jre )
	perl? ( dev-lang/perl )
	php? ( virtual/php
		dev-util/re2c )
	python? ( virtual/python )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use java; then
		epatch "${FILESDIR}/${P}-java-compiler.patch"
	fi
}

src_compile() {
	econf || die "configure failed"
	make DESTDIR=${D} || die "make failed"
	if use java; then
		cd "${S}/java_ext"
		make || "java make failed"
	fi
	if use perl; then
		cd "${S}/perl_ext"
		perl-module_src_compile || "perl make failed"
		perl-module_pkg_setup
		perl-module_pkg_preinst
	fi
	if use php; then
		cd "${S}/php_ext"
		einfo "**********************************************"
		einfo "The ming developers suggest using the built-in"
		einfo "PHP module if you are using PHP 5 or above."
		einfo "If so, please stop this ebuild and re-emerge ming"
		einfo "without using the php use flag."
		einfo "**********************************************"
		epause 5
		php-ext-source-r1_src_compile || "php make failed"
	fi
	if use python; then
		cd "${S}/py_ext"
		python_version
		distutils_src_compile || "python make failed"
	fi
}

src_install() {
	insopts -m0644
	insinto /usr/include
	doins src/ming.h src/ming_config.h mingpp.h
	dolib libming.so libming.so.0 libming.so.${PV} libming.a
	dodoc ChangeLog CREDITS HISTORY INSTALL LICENSE LICENSE_GPL2 NEWS README TODO
	doman man/makeswf.1
	cd "${S}/util"
	dobin listswf listswf_d swftoperl swftophp swftopython makeswf listaction listaction_d listfdb makefdb listjpeg raw2adpcm listmp3 gif2dbl gif2mask png2dbl png2swf ming-config dbl2png
	if use java; then
		cd "${S}/java_ext"
		java-pkg_doclass jswf.jar
	fi
	if use perl; then
		cd "${S}/perl_ext"
		perl-module_src_install
		dodoc CREDITS README SUPPORT TODO
	fi
	if use php; then
		cd "${S}/php_ext"
		php-ext-source-r1_src_install
		dodoc README
	fi
	if use python; then
		cd "${S}/py_ext"
		distutils_src_install
		python_mod_cleanup
		dodoc INSTALL
	fi
}

pkg_postinst() {
	if use java; then
		einfo "You may want to add ming to the java classpath by running"
		einfo "java-config --add-[user|system]-classpath=ming"
	fi
	if use perl; then
		perl-module_pkg_postinst
	fi
}
