# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gentoo-editor/gentoo-editor-2.ebuild,v 1.8 2010/01/19 17:54:49 armin76 Exp $

DESCRIPTION="Auxiliary editor script"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 m68k ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

src_install() {
	exeinto /usr/libexec
	newexe "${FILESDIR}/${P}.sh" gentoo-editor || die
}
