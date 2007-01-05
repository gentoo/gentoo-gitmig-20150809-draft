# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphviz/graphviz-1.12-r1.ebuild,v 1.10 2007/01/05 08:00:36 flameeyes Exp $

inherit eutils

DESCRIPTION="open source graph drawing software"
HOMEPAGE="http://www.research.att.com/sw/tools/graphviz/"
SRC_URI="http://www.graphviz.org/pub/graphviz/ARCHIVE/${P}.tar.gz
		mirror://gentoo/graphviz-1.12-configure.ac.bz2"

LICENSE="as-is ATT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc x86"
IUSE="tcltk"

#Can use freetype-1.3 or 2.0, but not both
DEPEND=">=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2
	>=media-libs/jpeg-6b
	media-libs/freetype
	dev-util/pkgconfig
	sys-devel/gettext
	tcltk? ( >=dev-lang/tk-8.3 )"

src_unpack() {
	unpack ${A}
	cd ${S}


	# this next chunk will be obsolete when 1.13 comes out
	# it's a buildfix so that graphviz will build when TckTk is NOT being used
	# and is not installed.
	epatch ${FILESDIR}/${P}-build.patch || die "Failed to patch"
	einfo "Installing new configure.ac"
	bzcat ${DISTDIR}/${P}-configure.ac.bz2 > ${S}/configure.ac || die "Failed to extract configure.ac"
	einfo "Removing old configure.in"
	rm -f ${S}/configure.in || die "Failed to remove old configure.in"
	einfo "Running aclocal/automake/autoconf"
	aclocal && automake && autoconf || die "Failed to aclocal/automake/autoconf"
}

src_compile() {
	local myconf

	# if no tcltk, this will generate configure warnings, but will
	# compile without tcltk support
	use tcltk || myconf="${myconf} --without-tcl --without-tk"

	econf ${myconf} || die "econf failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog FAQ.txt INSTALL  MINTERMS.txt \
		NEWS README

	dohtml -r .
	dodoc doc/*.pdf
}
