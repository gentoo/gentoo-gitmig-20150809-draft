# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-1.3.1-r3.ebuild,v 1.21 2004/03/19 07:56:03 mr_bones_ Exp $

IUSE="nls"

# r3 change by me (danarmak): there's a contrib dir inside the freetype1
# sources with important utils: ttf2bdf, ttf2pfb, ttf2pk, ttfbanner.
# These aren't build together with the main tree: you must configure/make
# separately in each util's directory. However ttf2pfb doesn't compile
# properly. Therefore we download freetype1-contrib.tar.gz which is newer
# and coresponds to freetype-pre1.4. (We don't have an ebuild for that
# because it's not stable?) We extract it to freetype-1.3.1/freetype1-contrib
# and build from there.
# When we update to freetype-pre1.4 or any later version, we should use
# the included contrib directory and not download any additional files.

inherit gnuconfig

P2=${PN}1-contrib
S=${WORKDIR}/${P}
DESCRIPTION="TTF-Library"
SRC_URI="ftp://ftp.freetype.org/freetype/freetype1/${P}.tar.gz
	ftp://ftp.freetype.org/freetype/freetype1/${P2}.tar.gz
	http://ftp.sunet.se/pub/text-processing/freetype/freetype1/${P}.tar.gz
	http://ftp.sunet.se/pub/text-processing/freetype/freetype1/${P2}.tar.gz"
HOMEPAGE="http://www.freetype.org/"

SLOT="1"
LICENSE="FTL"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"

DEPEND="virtual/glibc"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.gz
	# freetype1-contrib goes under freetype-1.3.1
	cd ${S}
	unpack ${P2}.tar.gz

	use amd64 && gnuconfig_update
	use alpha && gnuconfig_update
	use ia64 && gnuconfig_update
}

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die

	# Make a small fix to disable tests
	# Now xfree is no longer required
	cp Makefile Makefile.orig
	sed -e "s:ttlib tttest ttpo:ttlib ttpo:" Makefile.orig > Makefile

	make || die

	# make contrib utils
	for x in ttf2bdf ttf2pfb ttf2pk ttfbanner
	do
		cd ${S}/freetype1-contrib/${x}
		econf || die
		make || die
	done

}

src_install() {

	cd lib

	# Seems to require a shared libintl (getetxt comes only with a static one
	# But it seems to work without problems

	make -f arch/unix/Makefile prefix=${D}/usr install || die

	cd ${S}/po
	make prefix=${D}/usr install || die

	cd ${S}
	dodoc announce PATENTS README readme.1st
	dodoc docs/*.txt docs/FAQ docs/TODO
	dohtml -r docs

	# install contrib utils
	cd ${S}/freetype1-contrib
	into /usr
	dobin ttf2bdf/ttf2bdf \
	ttf2pfb/getafm ttf2pfb/t1asm ttf2pfb/.libs/ttf2pfb \
	ttf2pk/.libs/ttf2pk ttf2pk/.libs/ttf2tfm \
	ttfbanner/.libs/ttfbanner
	newman ttf2bdf/ttf2bdf.man ttf2bdf/ttf2bdf.man.1
	doman ttf2bdf/ttf2bdf.man.1
	docinto contrib
	dodoc ttf2pk/ttf2pk.doc

}
