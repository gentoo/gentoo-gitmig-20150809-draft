# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/namazu/namazu-2.0.20.ebuild,v 1.2 2010/08/12 09:18:37 maekke Exp $

inherit eutils elisp-common

IUSE="emacs nls tk linguas_ja"

DESCRIPTION="Namazu is a full-text search engine"
HOMEPAGE="http://www.namazu.org/"
SRC_URI="http://www.namazu.org/stable/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"

RDEPEND=">=dev-perl/File-MMagic-1.20
	emacs? ( virtual/emacs )
	linguas_ja? (
		app-i18n/nkf
		|| (
			dev-perl/Text-Kakasi
			app-i18n/kakasi
			app-text/chasen
			app-text/mecab
		)
	)
	nls? ( virtual/libintl )
	tk? (
		dev-lang/tk
		www-client/lynx
	)"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-2.0.19-gentoo.patch"
}

src_compile() {
	local myconf

	use tk && myconf="--with-namazu=/usr/bin/namazu
					--with-mknmz=/usr/bin/mknmz
					--with-indexdir=/var/lib/namazu/index"

	econf \
		$(use_enable nls) \
		$(use_enable tk tknamazu) \
		${myconf} || die
	emake || die

	if use emacs; then
		cd lisp
		elisp-compile gnus-nmz-1.el namazu.el || die
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS CREDITS ChangeLog* HACKING* NEWS README* THANKS TODO etc/*.png
	dohtml -r doc/*

	if use emacs; then
		elisp-install ${PN} lisp/gnus-nmz-1.el* lisp/namazu.el* || die
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
