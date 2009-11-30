# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gentoo-editor/gentoo-editor-2.ebuild,v 1.3 2009/11/30 14:44:47 volkmar Exp $

DESCRIPTION="Auxiliary editor script"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~x86-fbsd"
IUSE=""

src_install() {
	exeinto /usr/libexec
	newexe "${FILESDIR}/${P}.sh" gentoo-editor || die
}
