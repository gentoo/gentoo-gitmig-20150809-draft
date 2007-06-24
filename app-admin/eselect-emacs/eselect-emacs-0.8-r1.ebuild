# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-emacs/eselect-emacs-0.8-r1.ebuild,v 1.19 2007/06/24 21:09:33 vapier Exp $

DESCRIPTION="Manages the /usr/bin/emacs symlink"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.7"

src_install() {
	insinto /usr/share/eselect/modules
	doins emacs.eselect || die "doins failed"
	doman emacs.eselect.5 || die "doman failed"
}
