# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libtheora/libtheora-1.0_alpha6-r1.ebuild,v 1.9 2006/10/20 21:49:28 kloeri Exp $

inherit flag-o-matic libtool autotools

DESCRIPTION="The Theora Video Compression Codec"
HOMEPAGE="http://www.theora.org/"
SRC_URI="http://downloads.xiph.org/releases/theora/${P/_}.tar.bz2"

LICENSE="xiph"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 mips ppc ~ppc-macos ppc64 sh sparc x86 ~x86-fbsd"
IUSE="encode doc examples"

RDEPEND=">=media-libs/libogg-1.1.0
	encode? ( >=media-libs/libvorbis-1.0.1 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${P/_}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:SUBDIRS = .*:SUBDIRS = lib include doc:' Makefile.am

	epatch "${FILESDIR}/${P/_/}-buildfixes.patch"
	epatch "${FILESDIR}/${P}-pic-fix.patch"

	# Force automake 1.9 for newer autoconf
	WANT_AUTOMAKE="1.9" \
	AT_M4DIR="m4" eautoreconf

	elibtoolize

	if use examples; then
		# This creates a clean copy of examples sources
		cp -R "${S}/examples" "${WORKDIR}"
		rm -f "${WORKDIR}/examples/Makefile"*
	fi
}

src_compile() {
	# bug #75403, -O3 needs to be filtered to -O2
	replace-flags -O3 -O2

	use doc || export ac_cv_prog_HAVE_DOXYGEN="false"

	econf \
		$(use_enable encode) \
		--enable-shared \
		--disable-dependency-tracking \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		docdir="usr/share/doc/${PF}" \
		install || die "make install failed"

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins "${WORKDIR}/examples/"*
	fi

	dodoc README
}
