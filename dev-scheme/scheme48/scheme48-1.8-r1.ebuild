# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/scheme48/scheme48-1.8-r1.ebuild,v 1.2 2010/08/10 15:43:58 xarthisius Exp $

inherit elisp-common multilib eutils flag-o-matic

DESCRIPTION="Scheme48 is an implementation of the Scheme Programming Language."
HOMEPAGE="http://www.s48.org/"
SRC_URI="http://www.s48.org/${PV}/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc emacs"

DEPEND="emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"
SITEFILE=50scheme48-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-as-needed+fix_destdir.patch"
	sed -i -e "s/\$(LD) /&\$(LFLAGS) /" Makefile.in || die #332007
}

src_compile() {
	econf
	emake LFLAGS="$(raw-ldflags)" || die
	if use emacs; then
		elisp-compile "${S}"/emacs/cmuscheme48.el
	fi
}

src_install() {
	# weird parallel failures!
	emake -j1 DESTDIR="${D}" install || die

	if use emacs; then
		elisp-install ${PN} emacs/cmuscheme48.el emacs/*.elc
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	fi

	dodoc README || die
	if use doc; then
		dodoc doc/manual.ps doc/manual.pdf doc/*.txt || die
		dohtml -r doc/html/* || die
		docinto src
		dodoc doc/src/* || die
	fi

	#this symlink clashes with gambit
	rm "${D}"/usr/bin/scheme-r5rs
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
