# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gforth/gforth-0.6.1.ebuild,v 1.3 2003/09/06 22:27:51 msterret Exp $

IUSE="emacs"

inherit elisp

S=${WORKDIR}/${P}
DESCRIPTION="GNU Forth is a fast and portable implementation of the ANSI Forth language"
HOMEPAGE="http://www.gnu.org/software/gforth"
SRC_URI="http://www.complang.tuwien.ac.at/forth/gforth/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	emacs? ( virtual/emacs )"

SITEFILE=50gforth-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S} && patch -p0 <${FILESDIR}/gforth.el-gentoo.patch || die
}

src_compile() {
	econf --enable-force-reg --without-debug || die "./configure failed"
	make XCFLAGS="" ENGINE_FLAGS="" || die

	use emacs && emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install () {
	make install libdir=${D}/usr/lib \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		datadir=${D}/usr/share \
		bindir=${D}/usr/bin \
		install || die

	dodoc AUTHORS BUGS COPYING* ChangeLog NEWS* README* ToDo doc/glossaries.doc doc/*.ps

	if use emacs
	then
		elisp-install ${PN} *.el *.elc
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
