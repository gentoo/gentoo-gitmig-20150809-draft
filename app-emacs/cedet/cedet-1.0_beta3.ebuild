# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cedet/cedet-1.0_beta3.ebuild,v 1.1 2004/07/23 03:18:21 mkennedy Exp $

inherit elisp

MY_SUBPV=a
MY_PV=${PV:0:3}${PV:4:5}${MY_SUBPV}

IUSE=""
DESCRIPTION="CEDET: Collection of Emacs Development Tools"
HOMEPAGE="http://cedet.sourceforge.net/"
SRC_URI="mirror://sourceforge/cedet/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/emacs
	!app-emacs/semantic
	!app-emacs/eieio
	!app-emacs/speedbar"

S="${WORKDIR}/${PN}-${MY_PV}"

SITEFILE="60cedet-gentoo.el"

src_compile() {
	make EMACS=/usr/bin/emacs || die
}

src_install() {
	dodir /usr/share/emacs/site-lisp/cedet
	tar --create --verbose \
		--exclude=Makefile \
		--exclude=\*texi \
		--exclude=\*info\* \
		--exclude=README \
		--exclude=INSTALL \
		--exclude=\*NEWS \
		--exclude=ChangeLog \
		--exclude=\*~ \
		. | tar --extract --directory ${D}/usr/share/emacs/site-lisp/cedet/
	dodoc INSTALL
	doinfo `find . -type f -name \*.info\*`
	# The following finds documentation in sub-directories and flattens
	# the path names for dodoc
	mkdir docs || true
	find . -type f \( -name ChangeLog -o -name README -o -name AUTHORS -o -name \*NEWS \) -print \
		| sed -e 's,^./\(.*\)/\(.*\),cp \0 docs/\2.\1,g' \
		| sh -x
	dodoc docs/*
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

