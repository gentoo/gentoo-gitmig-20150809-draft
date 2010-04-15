# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swig/swig-1.3.40-r1.ebuild,v 1.1 2010/04/15 21:39:54 pchrist Exp $

EAPI="3"
#inherit autotools #mono #48511
DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="ccache doc"

DEPEND="test? ( dev-libs/boost )"
RDEPEND=""
#AM_OPTS="--add-missing --copy --force-missing"
src_prepare () {
	#eautoreconf --verbose || die "reconfiguring the build system failed"
	#use test && die
	rm -v aclocal.m4 || die "Unable to remove aclocal.m4"
	env - ./autogen.sh || die "Autogen script failed"
}

src_configure () {
		#--disable-dependency-tracking \
	econf \
		$(use_enable ccache)
}

src_test() {
	ewarn "It is known that some tests fail, sometimes. Be warned!"
	time env - make "${MAKEOPTS}" check || die "Tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ANNOUNCE CHANGES CHANGES.current FUTURE NEW README TODO || die
	( use doc && dohtml -r Doc/{Devel,Manual} ) || die
}
