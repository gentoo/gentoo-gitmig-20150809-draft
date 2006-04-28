# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/namazu/namazu-2.0.16.ebuild,v 1.1 2006/04/28 13:44:51 hattya Exp $

IUSE="chasen cjk emacs kakasi nls tcltk"

DESCRIPTION="Namazu is a full-text search engine"
HOMEPAGE="http://www.namazu.org/"
SRC_URI="http://www.namazu.org/stable/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="0"

DEPEND=">=dev-perl/File-MMagic-1.20
	cjk? ( app-i18n/nkf )
	nls? ( sys-devel/gettext )
	chasen? ( dev-perl/Text-ChaSen )
	kakasi? ( dev-perl/Text-Kakasi )
	tcltk?  ( dev-lang/tk www-client/lynx )"

src_unpack() {

	unpack ${A}
	cd ${S}

	sed -i -e "s:\(rm -f \$(filterdir).*$\):# \1:" filter/Makefile.in

}

src_compile() {

	local myconf

	use tcltk && myconf="--with-namazu=/usr/bin/namazu
					--with-mknmz=/usr/bin/mknmz
					--with-indexdir=/var/lib/namazu/index"

	econf \
		`use_enable nls` \
		`use_enable tcltk tknamazu` \
		${myconf} \
		|| die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	rm -rf ${D}/usr/share/namazu/{doc,etc}

	dodoc AUTHORS CREDITS ChangeLog* HACKING* NEWS README* THANKS TODO
	dohtml -r doc/*

	insinto /usr/share/doc/${P}
	doins etc/*.png

	if use emacs; then
		docinto lisp
		dodoc lisp/ChangeLog*

		insinto /usr/share/${PN}/lisp
		doins lisp/*.el
	fi

}
