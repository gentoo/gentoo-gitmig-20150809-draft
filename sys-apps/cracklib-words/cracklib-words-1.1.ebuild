# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cracklib-words/cracklib-words-1.1.ebuild,v 1.1 2005/02/12 20:21:06 vapier Exp $

DESCRIPTION="large set of crack/cracklib dictionaries"
HOMEPAGE="http://sourceforge.net/projects/cracklib"
SRC_URI="mirror://sourceforge/cracklib/${PN}.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_install() {
	insinto /usr/share/dict
	doins cracklib-words || die
}
