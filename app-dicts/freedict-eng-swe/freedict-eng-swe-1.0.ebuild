# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/freedict-eng-swe/freedict-eng-swe-1.0.ebuild,v 1.3 2003/02/13 06:26:35 vapier Exp $

IUSE=""

S=${WORKDIR}
DESCRIPTION="dict-freedict for language translation"
HOMEPAGE="http://www.freedict.de"
MY_P=${PN/freedict-/}
SRC_URI="http://freedict.sourceforge.net/download/linux/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="app-text/dictd"

src_install() {
	insinto /usr/lib/dict
	doins ${MY_P}.dict.dz
	doins ${MY_P}.index
}
