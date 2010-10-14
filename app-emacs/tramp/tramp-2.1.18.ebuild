# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tramp/tramp-2.1.18.ebuild,v 1.5 2010/10/14 16:51:45 ranger Exp $

inherit elisp

DESCRIPTION="Edit remote files like ange-ftp but with rlogin, telnet and/or ssh"
HOMEPAGE="http://www.gnu.org/software/tramp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.3"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

ELISP_PATCHES="${P}-fix-texinfo.patch"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	econf
	emake || die "emake failed"
	elisp-make-autoload-file lisp/${PN}-autoloads.el lisp || die
}

src_install() {
	einstall lispdir="${D}${SITELISP}/tramp" || die

	mv "${D}"/usr/share/info/tramp{,.info}

	dohtml texi/*.html
	if [ -f texi/tramp.dvi ]; then
		insinto /usr/share/doc/${PF}
		doins texi/tramp.dvi
	fi

	elisp-install ${PN} lisp/${PN}-autoloads.el || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	dodoc README ChangeLog CONTRIBUTORS || die
	newdoc lisp/ChangeLog ChangeLog-lisp || die
	newdoc texi/ChangeLog ChangeLog-texi || die
}
