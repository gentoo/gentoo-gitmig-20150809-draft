# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-1.4_pre20080316.ebuild,v 1.3 2008/04/27 13:12:43 fmccor Exp $

WANT_AUTOCONF="2.1"

inherit autotools eutils libtool multilib

DESCRIPTION="Freetype font rendering engine"
HOMEPAGE="http://www.freetype.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="FTL"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh sparc ~x86 ~x86-fbsd"
IUSE="doc nls kpathsea"

DEPEND="kpathsea? ( virtual/tex-base )
		>=sys-devel/autoconf-2.59"	# for contrib
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# remove unneeded include for BSD (#104016)
	epatch "${FILESDIR}"/freetype-1.4_pre-malloc.patch

	# fix ttf2pk to work with tetex 3.0
	epatch "${FILESDIR}"/freetype-1.4_pre-ttf2pk-tetex-3.patch

	# fix segfault due to undefined behaviour of non-static structs
	epatch "${FILESDIR}"/freetype-1.4_pre-ttf2tfm-segfault.patch

	# silence strict-aliasing warnings
	epatch "${FILESDIR}"/freetype-1.4_pre-silence-strict-aliasing.patch

	# add DESTDIR support to contrib Makefiles
	epatch "${FILESDIR}"/freetype-1.4_pre-contrib-destdir.patch

	# disable tests (they don't compile)
	sed -i -e "/^all:/ s:tttest ::" Makefile.in

	eautoreconf
	elibtoolize

	# contrib isn't compatible with autoconf-2.13
	unset WANT_AUTOCONF

	for x in ttf2bdf ttf2pfb ttf2pk ttfbanner; do
		cd "${S}"/freetype1-contrib/${x}
		eautoconf
	done
}

src_compile() {
	use kpathsea && kpathseaconf="--with-kpathsea-lib=/usr/$(get_libdir) --with-kpathsea-include=/usr/include"

	# core
	einfo "Building core library..."
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"

	# contrib
	cd "${S}"/freetype1-contrib/ttf2pk
	einfo "Building ttf2pk..."
	econf ${kpathseaconf} || die "econf ttf2pk failed"
	emake || "emake ttf2pk failed"
	for x in ttf2bdf ttf2pfb ttfbanner; do
		cd "${S}"/freetype1-contrib/${x}
		einfo "Building ${x}..."
		econf || die "econf ${x} failed"
		emake || die "emake ${x} failed"
	done
}

src_install() {
	dodoc announce PATENTS README docs/*.txt docs/FAQ
	use doc && dohtml -r docs

	# core
	# Seems to require a shared libintl (getetxt comes only with a static one
	# But it seems to work without problems
	einfo "Installing core library..."
	cd "${S}"/lib
	emake -f arch/unix/Makefile \
		prefix="${D}"/usr libdir="${D}"/usr/$(get_libdir) install \
			|| die "lib install failed"

	# install po files
	einfo "Installing po files..."
	cd "${S}"/po
	emake prefix="${D}"/usr libdir="${D}"/usr/$(get_libdir) install \
		|| die "po install failed"

	# contrib (DESTDIR now works here)
	einfo "Installing contrib..."
	for x in ttf2bdf ttf2pfb ttf2pk ttfbanner; do
		cd "${S}"/freetype1-contrib/${x}
		emake DESTDIR="${D}" install || die "${x} install failed"
	done

	# tex stuff
	if use kpathsea; then
		cd "${S}"/freetype1-contrib
		insinto /usr/share/texmf/ttf2pk
		doins ttf2pk/data/* || die "kpathsea ttf2pk install failed"
		insinto /usr/share/texmf/ttf2pfb
		doins ttf2pfb/Uni-T1.enc || die "kpathsea ttf2pfb install failed"
	fi
}
