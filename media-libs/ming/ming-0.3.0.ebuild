# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.3.0.ebuild,v 1.4 2007/02/22 16:57:24 chtekk Exp $

inherit eutils toolchain-funcs java-pkg perl-module python distutils

DESCRIPTION="An Open Source library for Flash movie generation."
HOMEPAGE="http://ming.sourceforge.net/"
SRC_URI="mirror://sourceforge/ming/${P}.tar.gz
		java? ( mirror://sourceforge/ming/${PN}-java-${PV}.tar.gz )
		perl? ( mirror://sourceforge/ming/${PN}-perl-${PV}.tar.gz )
		python? ( mirror://sourceforge/ming/${PN}-py-${PV}.tar.gz )"

IUSE="java perl python"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

RDEPEND="java? ( virtual/jre )
		perl? ( dev-lang/perl )
		python? ( virtual/python )"

DEPEND="${RDEPEND}
		sys-devel/flex
		java? ( virtual/jdk dev-java/java-config )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use java ; then
		epatch "${FILESDIR}/${P}-java-compiler.patch"
	fi
}

src_compile() {
	cd "${S}"
	econf || die "econf failed"
	emake DESTDIR="${D}" || die "emake failed"
	if use java ; then
		cd "${S}/java_ext"
		make || "java emake failed"
	fi
	if use perl ; then
		cd "${S}/perl_ext"
		perl-module_src_compile || "perl make failed"
		perl-module_pkg_setup
		perl-module_pkg_preinst
	fi
	if use python ; then
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
	dobin listswf listswf_d swftoperl swftophp swftopython makeswf listaction listaction_d listfdb makefdb listjpeg \
		raw2adpcm listmp3 gif2dbl gif2mask png2dbl png2swf ming-config dbl2png
	if use java ; then
		cd "${S}/java_ext"
		java-pkg_doclass jswf.jar
	fi
	if use perl ; then
		cd "${S}/perl_ext"
		perl-module_src_install
		dodoc CREDITS README SUPPORT TODO
	fi
	if use python ; then
		cd "${S}/py_ext"
		distutils_src_install
		python_mod_cleanup
		dodoc INSTALL
	fi
}

pkg_postinst() {
	if use java ; then
		einfo "You may want to add ming to the java classpath by running"
		einfo "java-config --add-[user|system]-classpath=ming"
	fi
	if use perl ; then
		perl-module_pkg_postinst
	fi
}
