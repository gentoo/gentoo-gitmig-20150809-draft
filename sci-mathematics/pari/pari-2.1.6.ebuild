# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/pari/pari-2.1.6.ebuild,v 1.7 2005/04/04 05:31:13 hardave Exp $

inherit eutils toolchain-funcs

DESCRIPTION="pari (or pari-gp) : a software package for computer-aided number theory"
HOMEPAGE="http://pari.math.u-bordeaux.fr/"
SRC_URI="http://pari.math.u-bordeaux.fr/pub/pari/unix/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa mips ppc ~sparc ~x86"
IUSE="doc emacs"

DEPEND="doc? ( virtual/tetex )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/docs.patch
	epatch ${FILESDIR}/wrong_functype-r1.patch
}

src_compile() {
	# Fix usage of toolchain
	tc-getAS; tc-getLD; tc-getCC; tc-getCXX
	./Configure \
		--host="$(echo ${CHOST} | cut -f "1 3" -d '-')" \
		--prefix=/usr \
		--miscdir=/usr/share/doc/${PF} \
		--datadir=/usr/share/${P} \
		--libdir=/usr/$(get_libdir) \
		--mandir=/usr/share/man/man1 || die "./configure failed"
	addwrite "/var/lib/texmf"
	addwrite "/usr/share/texmf"
	addwrite "/var/cache/fonts"

	# Shared libraries should be PIC on ALL architectures.
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/31
	# Fixes BUG #49583
	einfo "Building shared library..."
	cd Olinux-* || die "Bad directory. File a BUG!"
	emake CFLAGS="${CFLAGS} -DGCC_INLINE -fPIC" lib-dyn || die "Building shared library failed!"
	einfo "Building executables..."
	emake CFLAGS="${CFLAGS} -DGCC_INLINE" gp ../gp || die "Building executables failed!"

	use doc || rm -rf doc/*.tex
	use doc && emake doc
}

src_test() {
	cd ${S}
	ebegin "Testing pari kernel"
	make CFLAGS="-Wl,-lpari" test-kernel > /dev/null
	eend $?
}

src_install() {
	make DESTDIR=${D} LIBDIR=${D}/usr/$(get_libdir) install || die
	if use emacs; then
		insinto /usr/share/emacs/site-lisp
		doins emacs/pari.el
	fi
	dodoc AUTHORS Announce.2.1 CHANGES README TODO
}
