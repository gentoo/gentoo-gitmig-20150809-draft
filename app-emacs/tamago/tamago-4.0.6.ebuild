# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tamago/tamago-4.0.6.ebuild,v 1.10 2004/06/01 14:09:05 vapier Exp $

inherit elisp

DESCRIPTION="Emacs Backend for Sj3 Ver.2, FreeWnn, Wnn6 and Canna"
HOMEPAGE="http://www.m17n.org/tamago/"
SRC_URI="ftp://ftp.m17n.org/pub/tamago/${P}.tar.gz
	http://cgi18.plala.or.jp/nyy/canna/canna-20011204.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="virtual/emacs
	app-arch/gzip"
RDEPEND="virtual/emacs
	canna? ( app-i18n/canna )"

SITEFILE=50tamago-gentoo.el

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	zcat ${DISTDIR}/canna-20011204.diff.gz > canna-20011204.diff
	cat ${FILESDIR}/tamago-4.0.6-canna-gentoo.patch | patch
	patch -p1 < canna-20011204.diff
}

src_compile() {
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	dodir ${SITELISP}/${PN}
	emake prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN}  install || die

	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	dodoc README.ja.txt AUTHORS PROBLEMS TODO ChangeLog
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
