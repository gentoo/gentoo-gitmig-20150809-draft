# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lilypond/lilypond-2.12.3.ebuild,v 1.1 2010/04/13 18:35:47 chiiph Exp $

EAPI="3"

inherit eutils versionator toolchain-funcs elisp-common flag-o-matic

DESCRIPTION="GNU Music Typesetter"
SRC_URI="http://download.linuxaudio.org/lilypond/sources/v$(get_version_component_range 1-2)/${P}.tar.gz"
HOMEPAGE="http://lilypond.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"

IUSE="debug emacs profile"

RDEPEND="
	>=media-libs/freetype-2
	media-libs/fontconfig
	>=x11-libs/pango-1.12.3
	>=dev-scheme/guile-1.8.2[deprecated,regex]
	>=dev-lang/python-2.4
	|| ( >=app-text/ghostscript-gnu-8.15
		 >=app-text/ghostscript-gpl-8.15 )
	emacs? ( virtual/emacs )"

DEPEND="${RDEPEND}
	>=media-gfx/fontforge-20070501
	dev-texlive/texlive-metapost
	app-text/t1utils
	>=app-text/mftrace-1.2.9
	>=sys-apps/texinfo-4.11
	sys-devel/make
	sys-devel/gettext
	sys-devel/flex
	dev-lang/perl
	>=sys-devel/bison-2.0"

src_prepare() {
	epatch "${FILESDIR}"/${P}-qa_pyc_fix.patch
}

src_configure() {
	if [[ $(gcc-major-version) -lt 4 ]]; then
		eerror "You need GCC 4.x to build this software."
		die "you need to compile with gcc-4 or later"
	fi

	if use profile; then
		strip-flags -fomit-frame-pointer
	fi

	# see bug 228823
	econf --with-ncsb-dir=/usr/share/fonts/default/ghostscript \
		$(use_enable debug debugging) \
		$(use_enable profile profiling) \
		--disable-gui \
		--disable-documentation
}

src_compile() {
	# without -j1 it will not fail, but building docs later will, bug 236010
	emake -j1 || die "emake failed"

	if use emacs; then
		elisp-compile elisp/lilypond-{font-lock,indent,mode,what-beat}.el \
			|| die "elisp-compile failed"
	fi
}

# lilypond doesn't include the answers to the tests.
# You are supposed to build those yourself with an
# earlier version. Then running tests will compare the
# results of the tests against the results from the
# earlier version. As such, tests seem mostly useless
# for our purposes.
RESTRICT=test

src_install () {
	emake DESTDIR="${D}" vimdir=/usr/share/vim/vimfiles install || die "emake install failed"

	# remove elisp files since they are in the wrong directory
	rm -rf "${D}"/usr/share/emacs

	if use emacs; then
		elisp-install ${PN} elisp/*.{el,elc} elisp/out/*.el \
			|| die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}"/50${PN}-gentoo.el
	fi

	dodoc AUTHORS.txt HACKING NEWS.txt README.txt || die
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
