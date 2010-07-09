# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swig/swig-1.3.38.ebuild,v 1.2 2010/07/09 18:40:33 pchrist Exp $

inherit flag-o-matic mono eutils autotools #48511

DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc" #chicken clisp guile java lua mono mzscheme ocaml octave perl php pike python R ruby tcl tk" #gcj
RESTRICT="test"

DEPEND=""
RDEPEND=""

_DEPEND="
chicken? ( dev-scheme/chicken )
clisp? ( dev-lisp/clisp )
guile? ( dev-scheme/guile )
java? ( virtual/jdk )
lua? ( dev-lang/lua )
mono? ( dev-lang/mono )
mzscheme? ( dev-scheme/plt-scheme )
perl? ( dev-lang/perl )
php? ( dev-lang/php )
pike? ( dev-lang/pike )
python? ( virtual/python )
R? ( dev-lang/R )
ocaml? ( dev-lang/ocaml )
octave? ( sci-mathematics/octave )
ruby? ( virtual/ruby )
tcl? ( dev-lang/tcl )
tk? ( dev-lang/tk )
"
# gcj? ( sys-devel/gcc[+gcj] )

src_compile() {
	econf --without-mzscheme
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ANNOUNCE CHANGES CHANGES.current FUTURE NEW README TODO
	use doc && dohtml -r Doc/{Devel,Manual}
}
