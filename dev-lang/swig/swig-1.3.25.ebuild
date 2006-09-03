# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swig/swig-1.3.25.ebuild,v 1.12 2006/09/03 21:48:55 kumba Exp $

inherit flag-o-matic mono eutils #48511

DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 mips ppc ~ppc-macos ppc64 ~s390 sparc x86"
IUSE="doc guile java perl php python ruby tcl tk"

DEPEND="virtual/libc
	guile? ( >=dev-util/guile-1.4 )
	java? ( virtual/jdk )
	perl? ( >=dev-lang/perl-5.6.1 )
	php? ( virtual/php )
	python? ( virtual/python )
	ruby? ( virtual/ruby )
	tcl? ( dev-lang/tcl )
	tk? ( dev-lang/tk )"

src_compile() {
	strip-flags

	local myconf
	if use ruby ; then
		local rubyver="`ruby --version | cut -d '.' -f 1,2`"
		export RUBY="/usr/$(get_libdir)/ruby/${rubyver/ruby /}/"
	fi

	econf \
		$(use_with guile) \
		$(use_with java java "${JAVA_HOME}") \
		$(use_with java javaincl "${JAVA_HOME}/include") \
		$(use_with perl perl5 /usr/bin/perl) \
		$(use_with php php4) \
		$(use_with python python python) \
		$(use_with ruby ruby /usr/bin/ruby) \
		$(use_with tcl) \
		|| die

	has_version dev-lisp/mzscheme && PLT=/usr/share/mzscheme/collects
	has_version dev-lisp/plt && PLT=/usr/share/plt/collects

	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ANNOUNCE CHANGES CHANGES.current FUTURE NEW README TODO
	use doc && dohtml -r Doc/{Devel,Manual}
}

src_test() {
	einfo "FEATURES=\"maketest\" has been disabled for dev-lang/swig"
}
