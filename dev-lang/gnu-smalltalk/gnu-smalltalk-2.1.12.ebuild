# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnu-smalltalk/gnu-smalltalk-2.1.12.ebuild,v 1.7 2006/12/08 23:04:00 araujo Exp $

inherit elisp-common flag-o-matic eutils toolchain-funcs

DESCRIPTION="GNU Smalltalk"
HOMEPAGE="http://www.gnu.org/software/smalltalk/smalltalk.html"
SRC_URI="http://ftp.gnu.org/gnu/smalltalk/smalltalk-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86"
IUSE="tk readline emacs gtk gmp"

DEPEND="sys-libs/gdbm
	sys-apps/debianutils
	emacs? ( virtual/emacs )
	readline? ( sys-libs/readline )
	tk? ( dev-lang/tk )
	gtk? ( =x11-libs/gtk+-2* )
	gmp? ( dev-libs/gmp )"
RDEPEND=""

S=${WORKDIR}/smalltalk-${PV}

SITEFILE=50gnu-smalltalk-gentoo.el

src_unpack() {
	unpack ${A}
	sed -i "s:\$(DESTDIR)\$(bindir)/gst \$\$srcdir/Finish.st \-VisqS \-a \"\$(DESTDIR)\" \$(MODULES): :" ${S}/Makefile.am
	sed -i "s:\$(DESTDIR)\$(bindir)/gst \$\$srcdir/Finish.st \-VisqS \-a \"\$(DESTDIR)\" \$(MODULES): :" ${S}/Makefile.in
}

src_compile() {
	replace-flags '-O3' '-O2'
	./configure --prefix=/usr \
		`use_with emacs emacs` \
		`use_with readline readline` \
		`use_with gmp gmp` \
		`use_with tk tcl /usr/lib` \
		`use_with tk tk /usr/lib` \
		`use_enable gtk gtk` \
		|| die
	emake || die "emake failed"
	use emacs && elisp-compile *.el
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info \
		lispdir=${D}/usr/share/emacs/site-lisp/gnu-smalltalk install \
		|| die
	rm -rf ${D}/usr/include/sigsegv.h \
		${D}/usr/include/snprintfv \
		${D}/usr/share/aclocal/snprintfv.m4
	dodoc AUTHORS COPYING* ChangeLog NEWS PATCHES README THANKS TODO
	rm -rf ${D}/var
	if use emacs; then
		elisp-install ${PN} *.el *.elc
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
	fperms 0444 /usr/share/smalltalk/packages.xml
}

pkg_postinst() {
	einfo "We generate a GNU SmallTalk Image with the right image kernel path."
	cd /usr/share/smalltalk ; /usr/bin/gst -iQ dummy
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
