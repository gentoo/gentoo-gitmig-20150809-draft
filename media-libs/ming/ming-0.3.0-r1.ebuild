# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.3.0-r1.ebuild,v 1.13 2010/06/25 17:44:56 ssuominen Exp $

EAPI=1

PHP_EXT_NAME=ming

inherit eutils multilib autotools libtool perl-module distutils python php-ext-source-r1

KEYWORDS="hppa"
DESCRIPTION="An Open Source library for Flash movie generation."
HOMEPAGE="http://ming.sourceforge.net/"
SRC_URI="mirror://debian/pool/main/m/ming/ming_0.3.0.orig.tar.gz
	mirror://debian/pool/main/m/ming/ming_0.3.0-13.diff.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+perl +python php"
RDEPEND="perl? ( dev-lang/perl )
	python? ( virtual/python )
	media-libs/freetype
	media-libs/libpng
	media-libs/giflib
	sys-libs/zlib
	!media-libs/libswf
	!media-gfx/swftools"
DEPEND="${DEPEND}
	sys-devel/flex"

pkg_setup() {
	if use perl
	then
		perl-module_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ../ming_0.3.0-13.diff
	epatch "${FILESDIR}"/${P}--as-needed.patch
	elibtoolize
	eautoreconf
	if use php
	then
		cd "${S}"/php_ext
		php-ext-source-r1_phpize
	fi
}

src_compile() {
	econf || die "econf failed"
	emake -j1 DESTDIR="${D}" || die "emake failed"

	if use perl
	then
		cd "${S}/perl_ext"
		perl-module_src_compile || die "perl make failed"
	fi

	if use python
	then
		cd "${S}/py_ext"
		distutils_src_compile || die "python make failed"
	fi
	if use php
	then
		cd "${S}"/php_ext
		myconf="--disable-rpath
	                --disable-static
			--with-ming"
		php-ext-source-r1_src_compile
	fi
}

pkg_preinst() {
	if use perl
	then
		cd "${S}/perl_ext"
		perl-module_pkg_preinst
	fi
}

src_install() {
	insopts -m0644
	insinto /usr/include
	doins src/ming.h src/ming_config.h mingpp.h

	dolib libming.so libming.so.0 libming.so.${PV} libming.a || die "dolib failed"

	dodoc ChangeLog CREDITS HISTORY NEWS README TODO
	doman man/makeswf.1

	cd "${S}"/util
	dobin listswf listswf_d swftoperl swftophp swftopython makeswf listaction listaction_d listfdb makefdb listjpeg \
		raw2adpcm listmp3 gif2dbl gif2mask png2dbl png2swf ming-config dbl2png ttftofft || die "dobin failed"

	if use perl
	then
		cd "${S}"/perl_ext
		perl-module_src_install
		dodoc CREDITS README SUPPORT TODO
	fi

	if use python
	then
		cd "${S}"/py_ext
		distutils_src_install
	fi
	if use php
	then
		cd "${S}"/php_ext
		php-ext-source-r1_src_install
	fi
}

pkg_postinst() {
	if use perl
	then
		perl-module_pkg_postinst
	fi
	if use python
	then
		python_mod_optimize $(python_get_sitedir)/ming.py $(python_get_sitedir)/mingc.py
	fi
}

pkg_prerm() {
	if use perl
	then
		perl-module_pkg_prerm
	fi
}

pkg_postrm() {
	if use perl
	then
		perl-module_pkg_postrm
	fi
	if use python
	then
		distutils_pkg_postrm
	fi
}
