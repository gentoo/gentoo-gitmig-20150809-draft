# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/scheme48/scheme48-1.3-r1.ebuild,v 1.2 2006/08/31 03:45:58 mkennedy Exp $

inherit elisp-common multilib

DESCRIPTION="Scheme48 is an implementation of the Scheme Programming Language."
HOMEPAGE="http://www.s48.org/"
SRC_URI="http://www.s48.org/1.3/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 -amd64"
IUSE="doc emacs"

DEPEND="virtual/libc"
RDEPEND=""
SITEFILE=50scheme48-gentoo.el

src_unpack() {
	unpack ${A}
	sed -i "s:\`pwd\`:/usr/$(get_libdir)/scheme48:" ${S}/Makefile.in
	sed -i "s:lib=\$(LIB):lib=/usr/$(get_libdir)/scheme48:" ${S}/Makefile.in
	# Set the correct values for the paths show by the man pages
	sed -i "s:=\$(bindir)=:=/usr/bin/=:" ${S}/Makefile.in
	sed -i "s:=\$(LIB)=:=/usr/$(get_libdir)/scheme48=:" ${S}/Makefile.in
	# From Bug #127105
	sed -i 's:`(cd $(srcdir) && echo $$PWD)`/scheme:'"/usr/$(get_libdir)/scheme48/:" ${S}/Makefile.in
	sed -i "s:'\$(LIB)':'/usr/$(get_libdir)/\$(RUNNABLE)':" ${S}/Makefile.in
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	if use emacs; then
		elisp-compile ${S}/emacs/cmuscheme48.el
	fi
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
		install || die "make failed"
	if use emacs; then
		elisp-install ${PN} emacs/cmuscheme48.el emacs/*.elc
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
	dodoc README INSTALL
	if use doc; then
		dodoc doc/manual.ps doc/manual.pdf doc/*.txt
		dohtml -r doc/html/*
		docinto src
		dodoc doc/src/*
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
