# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-devils/dictd-devils-0-r1.ebuild,v 1.8 2004/03/06 04:52:06 vapier Exp $

MY_P=devils-dict-pre
S=${WORKDIR}
DESCRIPTION="The Devil's Dictionary for dict"
HOMEPAGE="http://www.dict.org/"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"

DEPEND=">=app-text/dictd-1.5.5"

src_install() {
	insinto /usr/lib/dict
	doins devils.dict.dz devils.index || die
}
