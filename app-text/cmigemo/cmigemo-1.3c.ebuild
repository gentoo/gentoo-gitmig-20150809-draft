# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cmigemo/cmigemo-1.3c.ebuild,v 1.2 2004/10/23 10:10:54 usata Exp $

inherit eutils

DESCRIPTION="C/Migemo -- Migemo library implementation in C"
HOMEPAGE="http://www.kaoriya.net/#CMIGEMO"
SRC_URI="http://www.kaoriya.net/dist/var/${P}.tar.bz2"

LICENSE="cmigemo"
SLOT="0"
KEYWORDS="x86 alpha ppc"	# development branch
IUSE="emacs"

DEPEND="virtual/libc
	app-i18n/qkc
	app-dicts/migemo-dict"
RDEPEND="virtual/libc
	app-dicts/migemo-dict
	emacs? ( >=app-text/migemo-0.40-r1 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2-migemo-dict.diff
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
