# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-emacs/eselect-emacs-1.4.ebuild,v 1.1 2008/05/13 10:53:17 ulm Exp $

DESCRIPTION="Manages Emacs versions"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=app-admin/eselect-1.0.10
	~app-admin/eselect-ctags-${PV}"

src_install() {
	insinto /usr/share/eselect/modules
	doins {emacs,etags}.eselect || die "doins failed"
	doman {emacs,etags}.eselect.5 || die "doman failed"
	dodoc ChangeLog || die "dodoc failed"
	dosbin "${FILESDIR}/emacs-updater" || die "dosbin failed"
}
