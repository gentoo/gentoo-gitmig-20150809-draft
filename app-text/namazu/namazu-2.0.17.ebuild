# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/namazu/namazu-2.0.17.ebuild,v 1.2 2007/08/25 15:28:30 hattya Exp $

IUSE="chasen cjk emacs kakasi nls tk"

DESCRIPTION="Namazu is a full-text search engine"
HOMEPAGE="http://www.namazu.org/"
SRC_URI="http://www.namazu.org/stable/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
SLOT="0"

DEPEND=">=dev-perl/File-MMagic-1.20
	chasen? ( app-text/chasen )
	cjk? ( app-i18n/nkf )
	kakasi? ( dev-perl/Text-Kakasi )
	nls? ( sys-devel/gettext )
	tk? (
		dev-lang/tk
		www-client/lynx
	)"

src_unpack() {

	unpack ${A}
	cd "${S}"

	sed -i "s:\(rm -f \$(filterdir).*$\):# \1:" filter/Makefile.in

}

src_compile() {

	local myconf

	use tk && myconf="--with-namazu=/usr/bin/namazu
					--with-mknmz=/usr/bin/mknmz
					--with-indexdir=/var/lib/namazu/index"

	econf \
		$(use_enable nls) \
		$(use_enable tk tknamazu) \
		${myconf} \
		|| die
	emake || die

}

src_install () {

	emake DESTDIR="${D}" install || die

	rm -rf "${D}"/usr/share/namazu/{doc,etc}

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
