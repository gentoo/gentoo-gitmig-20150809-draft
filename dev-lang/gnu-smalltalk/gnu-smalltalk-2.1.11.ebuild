# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnu-smalltalk/gnu-smalltalk-2.1.11.ebuild,v 1.1 2005/08/18 01:56:19 araujo Exp $

inherit elisp-common flag-o-matic eutils toolchain-funcs

DESCRIPTION="GNU Smalltalk"
HOMEPAGE="http://www.gnu.org/software/smalltalk/smalltalk.html"
SRC_URI="http://ftp.gnu.org/gnu/smalltalk/smalltalk-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="tcltk readline emacs gtk gmp"

DEPEND="sys-libs/gdbm
	sys-apps/debianutils
	emacs? ( virtual/emacs )
	readline? ( sys-libs/readline )
	tcltk? ( dev-lang/tcl dev-lang/tk )
	gtk? ( =x11-libs/gtk+-2* )
	gmp? ( dev-libs/gmp )"
RDEPEND=""

S=${WORKDIR}/smalltalk-${PV}

SITEFILE=50gnu-smalltalk-gentoo.el

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gst-image-temp.patch
	if has_version '>=dev-lang/gnu-smalltalk-2.1.8'; then
		einfo "You already have a gnu-smalltalk version installed"
		einfo "We set correct values for SMALLTALKIMAGE and SMALLTALKKERNEL during compilation"
		sed -i "s:getenv\ (\"SMALLTALK_KERNEL\"):\"${D}/usr/share/smalltalk\":" ${S}/libgst/lib.c
		sed -i "s:getenv\ (\"SMALLTALK_IMAGE\"):\"${D}/usr/share/smalltalk\":" ${S}/libgst/lib.c
	fi
}

src_compile() {
	local myconf=""
	if use tcltk; then
		myconf="
		`use_with tcltk tcl=/usr/lib` \
		`use_with tcltk tk=/usr/lib`"
	fi
	replace-flags '-O3' '-O2'
	econf \
		`use_with emacs emacs` \
		`use_with readline readline` \
		`use_with gmp gmp` \
		`use_enable gtk gtk` \
		${myconf} \
		|| die
	emake || die "emake failed"
	use emacs && elisp-compile *.el
}

src_install() {
	make DESTDIR=${D} lispdir=${D}/usr/share/emacs/site-lisp/gnu-smalltalk install \
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
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
