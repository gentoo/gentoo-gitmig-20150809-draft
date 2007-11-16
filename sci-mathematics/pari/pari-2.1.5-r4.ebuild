# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/pari/pari-2.1.5-r4.ebuild,v 1.6 2007/11/16 15:46:32 markusle Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="pari (or pari-gp) : a software package for computer-aided number theory"
HOMEPAGE="http://pari.math.u-bordeaux.fr/"
SRC_URI="http://pari.math.u-bordeaux.fr/pub/${PN}/unix/OLD/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ~ppc ~sparc x86"

IUSE="doc emacs"

DEPEND="doc? ( virtual/tetex )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/docs.patch
	epatch "${FILESDIR}"/wrong_functype.patch

}

src_compile() {
	#need to force optimization here, as it breaks without
	if   is-flag -O0; then
		replace-flags -O0 -O2
	elif ! is-flag -O?; then
		append-flags -O2
	fi

	#we also need to force -fPIC
	if ! is-flag -fPIC; then append-flags -fPIC; fi

	./Configure \
		--host="$(echo ${CHOST} | cut -f "1 3" -d '-')" \
		--prefix=/usr \
		--miscdir=/usr/share/doc/${P} \
		--datadir=/usr/share/${P} \
		--libdir=/usr/$(get_libdir) \
		--mandir=/usr/share/man/man1 || die "./configure failed"
	addwrite "/var/lib/texmf"
	addwrite "/usr/share/texmf"
	addwrite "/var/cache/fonts"
	if use amd64; then
		# Fixes BUG #49583
		einfo "Building shared library..."
		cd Olinux-x86_64
		emake CFLAGS="${CFLAGS} -DGCC_INLINE -fPIC" lib-dyn || die "Building shared library failed!"
		einfo "Building executables..."
		emake CFLAGS="${CFLAGS} -DGCC_INLINE" gp ../gp || die "Building exectuables failed!"
	elif use alpha; then
		einfo "Building shared library..."
		cd Olinux-alpha
		emake CFLAGS="${CFLAGS} -DGCC_INLINE -fPIC" lib-dyn || die "Building shared library failed!"
		einfo "Building executables..."
		emake CFLAGS="${CFLAGS} -DGCC_INLINE" gp ../gp || die "Building exec  tu  ables failed!"
	elif use hppa; then
		einfo "Building shared library..."
		cd Olinux-hppa*
		mymake=DLLD\=/usr/bin/gcc\ DLLDFLAGS\=-shared\ -Wl,-soname=\$\(LIBPARI_SONAME\)\ -lm
		emake CFLAGS="${CFLAGS} -DGCC_INLINE -fPIC" ${mymake} lib-dyn || die "Building shared library failed!"
		einfo "Building executables..."
		emake CFLAGS="${CFLAGS} -DGCC_INLINE" gp ../gp || die "Building exec  tu  ables failed!"
	else
		emake CFLAGS="${CFLAGS} -DGCC_INLINE" gp || die
	fi
	use doc || rm -rf doc/*.tex
	use doc && emake doc
}

src_install () {
	make DESTDIR="${D}" install || die
	if use emacs; then
		insinto /usr/share/emacs/site-lisp
		doins emacs/pari.el
	fi
	dodoc AUTHORS Announce.2.1 CHANGES README TODO
}
