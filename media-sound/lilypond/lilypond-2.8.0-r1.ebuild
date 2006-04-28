# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lilypond/lilypond-2.8.0-r1.ebuild,v 1.7 2006/04/28 03:40:13 weeve Exp $

inherit versionator

IUSE="debug emacs profile doc vim"

DESCRIPTION="GNU Music Typesetter"
SRC_URI="http://lilypond.org/download/v$(get_version_component_range 1-2)/${P}.tar.gz
	doc? ( http://lilypond.org/download/binaries/documentation/${P}-1.documentation.tar.bz2 )"
HOMEPAGE="http://lilypond.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"

RDEPEND=">=dev-util/guile-1.6.5
	|| (
		>app-text/ghostscript-gnu-8
		>app-text/ghostscript-afpl-8
		>app-text/ghostscript-esp-8
	)
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

src_unpack() {
	unpack ${A}
	# lilypond python scripts *prepend* /usr/share/lilypond/2.8.0/python to
	# sys.path, causing python to attempt to rebuild the pyc, which generates
	# sandbox errors (and is wrong anyway).  Change this policy to use
	# sys.path.append so that PYTHONPATH, set by the Makefiles, takes
	# precendence.
	grep -rlZ sys.path.insert --include \*.py ${S} \
		| xargs -0r sed -i 's/sys.path.insert \?(0, /sys.path.append (/'
}

src_compile() {
	addwrite /root/.PfaEdit  # fontforge, see bug 127723
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
	else
		rm -r ${D}/usr/share/lilypond/${PV}/vim
	fi

	# emacs (non-)support
	if ! use emacs; then
		rm -r ${D}/usr/share/emacs
	fi
}
