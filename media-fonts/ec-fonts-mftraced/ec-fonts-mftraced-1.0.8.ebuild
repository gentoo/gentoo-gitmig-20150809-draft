# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

DESCRIPTION="EC Fonts for Lilypond"
SRC_URI="http://lilypond.org/download/fonts/${P}.tar.gz"
HOMEPAGE="http://lilypond.org/"

SLOT="0"
LICENSE="public-domain"

KEYWORDS="~x86"

RDEPEND=">=dev-util/guile-1.6.4
	virtual/ghostscript
	virtual/tetex
	>=dev-lang/python-2.2.3-r1"

DEPEND="${RDEPEND}
	>=sys-devel/make-3.80
	>=app-text/mftrace-1.0.27
	>=media-gfx/potrace-1.5"

src_unpack() {
	unpack ${A} || die "unpack failed"
}

src_compile() {
	addwrite /dev/stderr
	addwrite /var/cache/fonts
	addwrite /usr/share/texmf/fonts
	addwrite /usr/share/texmf/ls-R

	# no need for econf.. this isn't an autoconf-generated configure
	./configure
	make all builddir=${S} prefix=${D}/usr/
}

src_install () {
	addwrite /dev/stderr
	addwrite /var/cache/fonts
	addwrite /usr/share/texmf/fonts
	addwrite /usr/share/texmf/ls-R

	make install builddir=${S} prefix=${D}/usr/
	mv ${D}/usr/share/doc/{${PN},${P}}
}

pkg_postinst() {
	texhash
}
