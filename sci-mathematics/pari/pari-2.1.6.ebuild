# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/pari/pari-2.1.6.ebuild,v 1.3 2005/03/29 03:07:35 vapier Exp $

inherit eutils

DESCRIPTION="pari (or pari-gp) : a software package for computer-aided number theory"
HOMEPAGE="http://pari.math.u-bordeaux.fr/"
SRC_URI="http://pari.math.u-bordeaux.fr/pub/pari/unix/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="doc emacs"

DEPEND="doc? ( virtual/tetex )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/docs.patch
	epatch ${FILESDIR}/wrong_functype-r1.patch
}

src_compile() {
	./Configure \
		--host="$(echo ${CHOST} | cut -f "1 3" -d '-')" \
		--prefix=/usr \
		--miscdir=/usr/share/doc/${PF} \
		--datadir=/usr/share/${P} \
		--mandir=/usr/share/man/man1 || die "./configure failed"
	addwrite "/var/lib/texmf"
	addwrite "/usr/share/texmf"
	addwrite "/var/cache/fonts"
	if use amd64 || use alpha || use hppa ; then
		# Fixes BUG #49583
		einfo "Building shared library..."
		cd Olinux-${CHOST%%-*}
		emake CFLAGS="${CFLAGS} -DGCC_INLINE -fPIC" lib-dyn || die "Building shared library failed!"
		einfo "Building executables..."
		emake CFLAGS="${CFLAGS} -DGCC_INLINE" gp ../gp || die "Building exectuables failed!"
	else
		emake CFLAGS="${CFLAGS} -DGCC_INLINE" gp || die
	fi
	use doc || rm -rf doc/*.tex
	use doc && emake doc
}

src_install () {
	make DESTDIR=${D} install || die
	if use emacs; then
		insinto /usr/share/emacs/site-lisp
		doins emacs/pari.el
	fi
	dodoc AUTHORS Announce.2.1 CHANGES README TODO
}
