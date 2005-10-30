# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/uim-el/uim-el-0.0.4.ebuild,v 1.1 2005/10/30 03:52:23 usata Exp $

inherit elisp eutils

IUSE=""

DESCRIPTION="UIM input method client for Emacs"
HOMEPAGE="http://garakuta.homelinux.org/~nosuke/tsubo/pukiwiki.php?%CA%AA%C3%D6%2Fuim.el"
SRC_URI="http://garakuta.homelinux.org/~nosuke/tsubo/files/linux/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
SLOT="0"

DEPEND="|| ( >=app-i18n/uim-0.4.6 app-i18n/uim-svn )"

src_compile() {
	econf || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	elisp-site-file-install ${FILESDIR}/50uim-el-gentoo.el

	dodoc AUTHORS ChangeLog README*
}

pkg_postinst() {
	elisp_pkg_postinst
	draw_line
	ewarn "Please read /usr/share/doc/${PF}/README.jp.gz before using."
	ewarn "You may need to set uim-default-im-engine and uim-default-im-prop."
}
