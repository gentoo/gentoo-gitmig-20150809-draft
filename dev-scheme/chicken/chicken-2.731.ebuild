# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/chicken/chicken-2.731.ebuild,v 1.1 2007/11/28 17:09:59 hkbst Exp $

inherit multilib elisp-common

DESCRIPTION="Chicken is a Scheme interpreter and native Scheme to C compiler"
#SRC_URI="http://www.call-with-current-continuation.org/${P}.tar.gz"
SRC_URI="http://chicken.wiki.br/dev-snapshots/2007/10/30/${P}.tar.gz"
#		 http://www.call-with-current-continuation.org/eggs/syntax-case.egg"
HOMEPAGE="http://www.call-with-current-continuation.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="emacs"

DEPEND="sys-apps/texinfo emacs? ( virtual/emacs )"

SITEFILE=50hen-gentoo.el

src_compile() {
	OPTIONS="PLATFORM=linux PREFIX=/usr"

	emake ${OPTIONS} C_COMPILER_OPTIMIZATION_OPTIONS="$CFLAGS" || die

	use emacs && elisp-comp hen.el
}

# chicken doesn't seem to honor CHICKEN_PREFIX CHICKEN_HOME or LD_LIBRARY_PATH=${S}/.libs/
RESTRICT=test
#src_test() {
#	cd tests
#	bash runtests.sh
#}

src_install() {
	emake ${OPTIONS} DESTDIR="${D}" install || die
	dodoc ChangeLog* NEWS
	dohtml -r html/
	rm -rf "${D}"/usr/share/chicken/doc

	if use emacs; then
		elisp-install ${PN} *.{el,elc}
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
