# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/vim-plugin.eclass,v 1.1 2003/07/30 18:47:06 agriffis Exp $
#
# This eclass simplifies installation of app-vim plugins into
# /usr/share/vim/vimfiles.  This is a version-independent directory
# which is read automatically by vim.  The only exception is
# documentation, for which we make a special case via vim-doc.eclass

inherit vim-doc
ECLASS=vim-plugin
INHERITED="$INHERITED $ECLASS"

IUSE=""
DEPEND="|| ( >=app-editors/vim-6.2 >=app-editors/gvim-6.2 )"
RDEPEND="${DEPEND}"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
SLOT="0"

src_install() {
	cd ${WORKDIR}
	chmod -R a+rX ${S}
	dodir /usr/share/vim
	mv ${S} ${D}/usr/share/vim/vimfiles
}

pkg_postinst() {
	update_vim_helptags
}

pkg_postrm() {
	update_vim_helptags
}
