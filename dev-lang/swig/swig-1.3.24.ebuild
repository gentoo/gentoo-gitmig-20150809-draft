# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swig/swig-1.3.24.ebuild,v 1.3 2005/08/10 18:10:17 kito Exp $

inherit flag-o-matic mono #48511

DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"
IUSE="java guile python tcltk ruby perl php X"

DEPEND="virtual/libc
	python? ( >=dev-lang/python-2.0 )
	java? ( virtual/jdk )
	ruby? ( virtual/ruby )
	guile? ( >=dev-util/guile-1.4 )
	tcltk? (
		dev-lang/tcl
		X? ( dev-lang/tk )
	)
	perl? ( >=dev-lang/perl-5.6.1 )
	php? ( >=dev-php/php-4.0.0 )"

S=${WORKDIR}/SWIG-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:-name jni_md.h -print:-xtype f -name jni_md.h -print:g' configure
}

src_compile() {
	strip-flags

	local myconf
	if use ruby ; then
		local rubyver="`ruby --version | cut -d '.' -f 1,2`"
		export RUBY="/usr/lib/ruby/${rubyver/ruby /}/"
	fi

	econf \
		`use_with python py` \
		`use_with java java "${JAVA_HOME}"` \
		`use_with java javaincl "${JAVA_HOME}/include"` \
		`use_with ruby ruby /usr/bin/ruby` \
		`use_with guile` \
		`use_with tcltk tcl` \
		`use_with perl perl5 /usr/bin/perl` \
		`use_with php php4` \
		|| die

	# fix the broken configure script
	use tcltk || sed -i -e "s:am__append_1 =:#am__append_1 =:" Runtime/Makefile

	`has_version dev-lisp/plt` && PLT=/usr/share/plt/collects
	`has_version dev-lisp/mzscheme` && PLT=/usr/share/mzscheme/collects

	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ANNOUNCE CHANGES FUTURE NEW README TODO
}

src_test() {
	einfo "FEATURES=\"maketest\" has been disabled for dev-lang/swig"
}
