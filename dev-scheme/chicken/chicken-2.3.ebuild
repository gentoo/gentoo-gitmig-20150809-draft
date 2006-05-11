# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/chicken/chicken-2.3.ebuild,v 1.1 2006/05/11 16:52:55 mkennedy Exp $

inherit multilib elisp-common

DESCRIPTION="Chicken is a Scheme interpreter and native Scheme to C compiler"
SRC_URI="http://www.call-with-current-continuation.org/${P}.tar.gz"
HOMEPAGE="http://www.call-with-current-continuation.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="emacs"

DEPEND="dev-libs/libpcre
	emacs? ( virtual/emacs )"

SITEFILE=50hen-gentoo.el

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
	make check || die
	use emacs && elisp-comp hen.el
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog* README NEWS TASKS
	dohtml chicken.html
	rm -rf ${D}/usr/share/chicken/doc
	if use emacs; then
		elisp-install ${PN} *.{el,elc}
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
