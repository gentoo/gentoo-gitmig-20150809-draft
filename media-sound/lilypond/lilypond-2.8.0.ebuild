# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lilypond/lilypond-2.8.0.ebuild,v 1.2 2006/03/26 21:51:40 agriffis Exp $

inherit versionator

IUSE="debug emacs profile doc vim"

DESCRIPTION="GNU Music Typesetter"
SRC_URI="http://lilypond.org/download/v$(get_version_component_range 1-2)/${P}.tar.gz
	doc? ( http://lilypond.org/download/binaries/documentation/${P}-1.documentation.tar.bz2 )"
HOMEPAGE="http://lilypond.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=dev-util/guile-1.6.5
	>=virtual/ghostscript-8.15
	virtual/tetex
	>=dev-lang/python-2.2.3-r1
	>=media-libs/freetype-2
	>=media-libs/fontconfig-2.2
	>=x11-libs/pango-1.6"

DEPEND="${RDEPEND}
	>=app-text/t1utils-1.32
	>=dev-lang/perl-5.8.0-r12
	>=sys-apps/texinfo-4.8
	>=sys-devel/flex-2.5.4a-r5
	>=sys-devel/gcc-3.3
	>=sys-devel/make-3.80
	>=app-text/mftrace-1.1.17
	>=media-gfx/fontforge-20050624
	sys-devel/bison !=sys-devel/bison-1.75"

src_compile() {
	addwrite /var/cache/fonts
	addwrite /usr/share/texmf/fonts
	addwrite /usr/share/texmf/ls-R

	econf \
		$(use_enable debug debugging) \
		$(use_enable profile profiling) \
		--with-ncsb-dir=/usr/share/fonts/default/ghostscript \
		|| die "econf failed"
	LC_ALL=C emake || die "emake failed"
}

src_install () {
	make install DESTDIR=${D} || die "install failed"

	dodoc COPYING ChangeLog NEWS.txt README.txt || die "dodoc failed"

	if use doc; then
		cp -dr ${WORKDIR}/{Documentation,examples.html,input} \
			${D}/usr/share/doc/${PF}/ || die "doc install failed"
	fi

	# vim support
	if use vim; then
		dodir /usr/share/vim
		mv ${D}/usr/share/lilypond/${PV}/vim \
			${D}/usr/share/vim/vimfiles || die "lilypond vim install failed"
	fi

	# emacs support, should this be done differently?
	if use emacs; then
		insinto /usr/share/${PN}/elisp
		doins elisp/*.el \
			|| die "lilypond emacs install failed"
		insinto /usr/share/${PN}/elisp/out
		doins elisp/out/lilypond-words.el \
			|| die "lilypond emacs install failed"
	fi
}
