# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gforth/gforth-0.5.0-r1.ebuild,v 1.1 2004/07/29 01:11:41 jbms Exp $

IUSE="emacs"

inherit flag-o-matic elisp-common

DESCRIPTION="GNU Forth is a fast and portable implementation of the ANS Forth language"
HOMEPAGE="http://www.gnu.org/software/gforth"
SRC_URI="http://www.complang.tuwien.ac.at/forth/gforth/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# Admittedly this should be UNSTABLE
KEYWORDS="~x86"

DEPEND="virtual/libc
	emacs? ( virtual/emacs )"

SITEFILE=50gforth-gentoo.el

src_compile() {
	# A lot of trouble with gcc3 and heavy opt flags, so let's try to dial
	# it down to -O1 at the most.
	strip-flags
	export CFLAGS="${CFLAGS//-O?} -O"

	econf --enable-force-reg --without-debug || die "./configure failed"
	# some configure flags that trip up gcc3.x are
	# built into the thing.  Get rid of the things.
	cp Makefile Makefile.orig
	sed -e "s:-O3::" Makefile.orig >Makefile
	cp engine/Makefile engine/Makefile.orig
	sed -e "s:-O3::" engine/Makefile.orig >engine/Makefile
	emake XCFLAGS="" ENGINE_FLAGS="" || die

	if use emacs; then
		elisp-comp *.el || die
	fi
}

src_install () {
	make install \
		prefix=${D}/usr \
		libdir=${D}/usr/lib \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		datadir=${D}/usr/share \
		bindir=${D}/usr/bin \
		install || die

	dodoc AUTHORS README INSTALL NEWS doc/glossaries.doc gforth.ps || die

	if use emacs; then
		elisp-install ${PN} *.el *.elc || die
		elisp-site-file-install ${FILESDIR}/${SITEFILE} || die
	fi
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
	fi
}

pkg_postrm() {
	if use emacs; then
		elisp-site-regen
	fi
}
