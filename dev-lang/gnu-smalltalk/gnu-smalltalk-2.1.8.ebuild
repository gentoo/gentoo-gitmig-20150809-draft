# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnu-smalltalk/gnu-smalltalk-2.1.8.ebuild,v 1.2 2004/07/16 09:43:58 dholm Exp $

inherit elisp-common flag-o-matic eutils gcc

DESCRIPTION="GNU Smalltalk"
HOMEPAGE="http://www.gnu.org/software/smalltalk/smalltalk.html"
SRC_URI="http://ftp.gnu.org/gnu/smalltalk/smalltalk-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="tcltk readline emacs gtk gmp"

DEPEND="dev-libs/gmp
	sys-libs/gdbm
	sys-apps/debianutils
	emacs? ( virtual/emacs )
	readline? ( sys-libs/readline )
	tcltk? ( dev-lang/tcl dev-lang/tk )
	gtk? ( =x11-libs/gtk+-2* )
	gmp? ( dev-libs/gmp )"

S=${WORKDIR}/smalltalk-${PV}

SITEFILE=50gnu-smalltalk-gentoo.el

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gst-package-mktemp-gentoo.patch
}

src_compile() {
	replace-flags '-O3' '-O2'
	econf \
		`use_with emacs emacs` \
		`use_with readline readline` \
		`use_with tcltk tcl=/usr/lib` \
		`use_with tcltk tk=/usr/lib` \
		`use_with gmp gmp` \
		`use_enable gtk gtk` \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} lispdir=/usr/share/emacs/site-lisp/gnu-smalltalk install || die
	rm -rf ${D}/usr/include/sigsegv.h \
		${D}/usr/include/snprintfv \
		${D}/usr/share/aclocal/snprintfv.m4
	dodoc AUTHORS COPYING* ChangeLog NEWS PATCHES README THANKS TODO
	use emacs && elisp-site-file-install ${FILESDIR}/${SITEFILE}

}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
