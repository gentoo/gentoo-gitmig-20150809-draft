# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/namazu/namazu-2.0.13.ebuild,v 1.1 2004/07/25 07:57:12 hattya Exp $

IUSE="chasen cjk emacs kakasi nls tcltk"

DESCRIPTION="Namazu is a full-text search engine"
HOMEPAGE="http://www.namazu.org/"
SRC_URI="http://www.namazu.org/stable/${P}.tar.gz"

RESTRICT="nomirror"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=dev-perl/File-MMagic-1.12
	cjk? ( app-i18n/nkf )
	nls? ( sys-devel/gettext )
	chasen? ( dev-perl/Text-ChaSen )
	kakasi? ( dev-perl/Text-Kakasi )
	tcltk?  ( dev-lang/tk net-www/lynx )"

src_compile() {

	econf \
		`use_enable nls` \
		`use_enable tcltk tknamazu` \
		|| die
	sed -ie "s:\(rm -f \$(filterdir).*$\):# \1:" filter/Makefile
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	rm -r ${D}/usr/share/namazu/etc

	rm *NLS
	dodoc [A-Z][A-Z]* ChangeLog*

	if use emacs; then
		docinto lisp
		dodoc lisp/ChangeLog*

		insinto /usr/share/${PN}/lisp
		doins lisp/*.el
	fi

}
