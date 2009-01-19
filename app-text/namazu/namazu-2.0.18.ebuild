# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/namazu/namazu-2.0.18.ebuild,v 1.6 2009/01/19 01:13:03 tcunha Exp $

inherit elisp-common

IUSE="chasen cjk emacs kakasi nls tk"

DESCRIPTION="Namazu is a full-text search engine"
HOMEPAGE="http://www.namazu.org/"
SRC_URI="http://www.namazu.org/stable/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc x86"
SLOT="0"

DEPEND=">=dev-perl/File-MMagic-1.20
	chasen? ( app-text/chasen )
	cjk? ( app-i18n/nkf )
	emacs? ( virtual/emacs )
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

	if use emacs; then
		cd lisp
		rm -f browse*
		elisp-compile *.el || die
	fi

}

src_install () {

	emake DESTDIR="${D}" install || die

	rm -rf "${D}"/usr/share/namazu/{doc,etc}

	dodoc AUTHORS CREDITS ChangeLog* HACKING* NEWS README* THANKS TODO
	dohtml -r doc/*

	insinto /usr/share/doc/${P}
	doins etc/*.png

	if use emacs; then
		elisp-install ${PN} lisp/*.el* || die
		elisp-site-file-install "${FILESDIR}"/50${PN}-gentoo.el || die

		docinto lisp
		dodoc lisp/ChangeLog*
	fi

}

pkg_postinst() {

	use emacs && elisp-site-regen

}

pkg_postrm() {

	use emacs && elisp-site-regen

}
