# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cmigemo/cmigemo-1.2.ebuild,v 1.3 2004/04/07 21:40:05 vapier Exp $

inherit eutils

DESCRIPTION="C/Migemo -- Migemo library implementation in C"
HOMEPAGE="http://www.kaoriya.net/#CMIGEMO"
SRC_URI="http://www.kaoriya.net/dist/${P}.tar.bz2"

LICENSE="cmigemo"
SLOT="0"
KEYWORDS="~x86 ~alpha"
IUSE="emacs"

DEPEND="virtual/glibc
	app-i18n/qkc
	app-dicts/migemo-dict"
RDEPEND="virtual/glibc
	app-dicts/migemo-dict
	emacs? ( >=app-text/migemo-0.40-r1 )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-migemo-dict.diff
	touch ${S}/dict/SKK-JISYO.L
}

src_compile() {
	emake CFLAGS="-fPIC ${CFLAGS}" gcc || die
}

src_install() {
	make \
		prefix=${D}/usr \
		docdir=${D}/usr/share/doc/${P} \
		gcc-install || die

	mv ${D}/usr/share/migemo/euc-jp/*.dat ${D}/usr/share/migemo
	rm -rf ${D}/usr/share/migemo/{cp932,euc-jp}

	if has_version 'app-editors/vim-core' ; then
		insinto /usr/share/vim/vimfiles/plugin
		doins tools/migemo.vim
	fi

	dodoc tools/migemo.vim
	dodoc doc/{README_j,TODO_j,vimigemo}.txt
}

pkg_postinst() {
	if use emacs ; then
		einfo ""
		einfo "Please add to your ~/.emacs"
		einfo "    (setq migemo-command \"cmigemo\")"
		einfo "    (setq migemo-options '(\"-q\" \"--emacs\" \"-i\" \"\\\\a\"))"
		einfo "    (setq migemo-dictionary \"/usr/share/migemo/migemo-dict\")"
		einfo "    (setq migemo-user-dictionary nil)"
		einfo "    (setq migemo-regex-dictionary nil)"
		einfo "to use cmigemo instead of migemo under emacs."
		einfo ""
	fi
}
