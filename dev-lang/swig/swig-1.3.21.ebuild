# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swig/swig-1.3.21.ebuild,v 1.20 2004/07/16 01:33:32 tgall Exp $

inherit mono #48511

DESCRIPTION="Simplied Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE="java guile python tcltk ruby perl php"

DEPEND="virtual/libc
	python? ( >=dev-lang/python-2.0 )
	java? ( virtual/jdk )
	ruby? ( virtual/ruby )
	guile? ( >=dev-util/guile-1.4 )
	tcltk? ( >=dev-lang/tk-8.3 )
	perl? ( >=dev-lang/perl-5.6.1 )
	!arm? ( !mips? ( php? ( >=dev-php/php-4.0.0 ) ) )"

S=${WORKDIR}/SWIG-${PV}

src_compile() {
	local myc

	use python && myc="$myc --with-py" \
		   || myc="$myc --without-py"
	use java && myc="$myc --with-java=$JAVA_HOME --with-javaincl=${JAVA_HOME}/include" \
		 || myc="$myc --without-java"
	use ruby && myc="$myc --with-ruby=/usr/bin/ruby" \
		 || myc="$myc --without-ruby"
	use guile && myc="$myc --with-guile" \
		  || myc="$myc --without-guile"
	use tcltk && myc="$myc --with-tcl" \
		  || myc="$myc --without-tcl"
	use perl && myc="$myc --with-perl" \
		 || myc="$myc --without-perl"
	use php && myc="$myc --with-php" \
		 || myc="$myc --without-php"

	unset CXXFLAGS
	unset CFLAGS

	use ruby && local rubyver="`ruby --version | cut -d '.' -f 1,2`"
	use ruby && RUBY="/usr/lib/ruby/${rubyver/ruby /}/"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
			$myc || die "./configure failed"

	# fix the broken configure script
	use tcltk || sed -i -e "s:am__append_1 =:#am__append_1 =:" Runtime/Makefile

	`has_version dev-lisp/plt` && PLT=/usr/share/plt/collects
	`has_version dev-lisp/mzscheme` && PLT=/usr/share/mzscheme/collects

	emake || die
	emake runtime PLTCOLLECTS=$PLT || die
}

src_install () {
	make prefix=${D}/usr install || die
	make prefix=${D}/usr install-runtime || die
}
