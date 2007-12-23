# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linuxfromscratch-html/linuxfromscratch-html-6.3.ebuild,v 1.1 2007/12/23 16:50:32 dirtyepic Exp $

MY_P="LFS-BOOK-${PV}-HTML"
DESCRIPTION="The Linux From Scratch Book. HTML Format"
HOMEPAGE="http://www.linuxfromscratch.org/"
SRC_URI="http://www.linuxfromscratch.org/lfs/downloads/${PV}/${MY_P}.tar.bz2"

LICENSE="LFS"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	dohtml -r * || die "install failed"
}
