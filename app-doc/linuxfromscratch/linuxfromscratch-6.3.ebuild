# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linuxfromscratch/linuxfromscratch-6.3.ebuild,v 1.1 2008/06/19 04:45:34 dirtyepic Exp $

MY_SRC="http://www.linuxfromscratch.org/lfs/downloads/${PV}"

DESCRIPTION="LFS documents building a Linux system entirely from source."
HOMEPAGE="http://www.linuxfromscratch.org/lfs"
SRC_URI="${MY_SRC}/LFS-BOOK-${PV}-HTML.tar.bz2
		${MY_SRC}/lfs-bootscripts-${PV}.tar.bz2
		${MY_SRC}/udev-config-${PV}.tar.bz2
		htmlsingle? ( ${MY_SRC}/LFS-BOOK-${PV}-NOCHUNKS.html.bz2 )
		pdf? ( ${MY_SRC}/LFS-BOOK-${PV}.pdf.bz2 )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="htmlsingle pdf"

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_install() {
	# We don't want this stuff compressed
	insinto /usr/share/doc/${PF}
	doins -r * || die "Install failed."
}
