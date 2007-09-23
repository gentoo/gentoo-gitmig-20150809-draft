# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnu-smalltalk/gnu-smalltalk-2.3.6.ebuild,v 1.1 2007/09/23 18:31:15 araujo Exp $

inherit multilib elisp-common flag-o-matic eutils toolchain-funcs

DESCRIPTION="GNU Smalltalk"
HOMEPAGE="http://smalltalk.gnu.org"
SRC_URI="http://ftp.gnu.org/gnu/smalltalk/smalltalk-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
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
	# stack patch
	epatch ${FILESDIR}/gst-stack-${PV}.patch
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
		lispdir=${D}/usr/share/emacs/site-lisp/gnu-smalltalk \
		libdir=${D}/usr/lib install || die
	rm -rf ${D}/usr/include/sigsegv.h \
		${D}/usr/include/snprintfv \
		${D}/usr/share/aclocal/snprintfv.m4
	dodoc AUTHORS COPYING* ChangeLog NEWS README THANKS TODO
	rm -rf ${D}/var
	if use emacs; then
		elisp-install ${PN} *.el *.elc
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
	fperms 0444 /usr/share/smalltalk/packages.xml
}

pkg_postinst() {
	einfo "We generate a GNU SmallTalk Image with the right kernel image path."
	cd /usr/share/smalltalk/
	/usr/bin/gst -iQ /dev/null
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
