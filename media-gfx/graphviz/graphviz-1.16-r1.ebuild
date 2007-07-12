# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphviz/graphviz-1.16-r1.ebuild,v 1.8 2007/07/12 04:08:47 mr_bones_ Exp $

inherit eutils flag-o-matic

DESCRIPTION="open source graph drawing software"
HOMEPAGE="http://www.research.att.com/sw/tools/graphviz/"
SRC_URI="http://www.graphviz.org/pub/graphviz/ARCHIVE/${P}.tar.gz
	ppc-macos? ( mirror://gentoo/${P}-panic.patch.tar.bz2 )"

LICENSE="as-is ATT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc-macos ppc64 s390 sh sparc x86"
IUSE="tk"

#Can use freetype-1.3 or 2.0, but not both
DEPEND=">=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2
	>=media-libs/jpeg-6b
	media-libs/freetype
	dev-util/pkgconfig
	sys-devel/gettext
	>=media-libs/gd-2.0.29
	media-libs/fontconfig
	tk? ( >=dev-lang/tk-8.3 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-build.patch
	epatch ${FILESDIR}/${P}-tempdir.patch

	if use ppc-macos; then
		# fixes weird make issue
		epatch ${WORKDIR}/${P}-panic.patch
		epatch ${FILESDIR}/${P}-common_h.patch
	fi

	if ! use ppc-macos; then
		#EPATCH_OPTS="-p1 -d${S}" epatch ${FILESDIR}/${P}-fontconfig-externalgd.diff || die "Failed to patch"
		einfo "Running aclocal/automake/autoconf"
		aclocal && libtoolize --copy --force && automake -a && autoconf || die "Failed	to aclocal/libtoolize/automake/autoconf"
	fi
}

src_compile() {
	local myconf

	# if no tk, this will generate configure warnings, but will
	# compile without tcl and tk support
	use tk || myconf="${myconf} --without-tcl --without-tk"

	myconf="${myconf} --enable-dynagraph --with-mylibgd"
	use ppc-macos && myconf="${myconf} --with-expatincludedir=/usr/X11R6/include --with-expatlibdir=/usr/X11R6/lib --with-fontconfigincludedir=/usr/X11R6/include --with-fontconfiglibdir=/usr/X11R6/lib"
	econf ${myconf} || die "econf failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog FAQ.txt INSTALL*  MINTERMS.txt \
		NEWS README*

	insinto /usr/share/doc/${PF}/
	doins doc/*.pdf

	dohtml -r .
	dodoc doc/*.pdf doc/Dot.ref
}
