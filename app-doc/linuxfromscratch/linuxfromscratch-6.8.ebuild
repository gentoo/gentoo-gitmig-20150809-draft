# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linuxfromscratch/linuxfromscratch-6.8.ebuild,v 1.1 2011/04/13 08:42:26 dirtyepic Exp $

EAPI="4"

MY_SRC="http://www.linuxfromscratch.org/lfs/downloads/${PV}"

BOOTSCRIPT_PV="20100627"
UDEV_PV="20100128"

DESCRIPTION="LFS documents building a Linux system entirely from source."
HOMEPAGE="http://www.linuxfromscratch.org/lfs"
SRC_URI="${MY_SRC}/LFS-BOOK-${PV}-HTML.tar.bz2
		${MY_SRC}/lfs-bootscripts-${BOOTSCRIPT_PV}.tar.bz2
		${MY_SRC}/udev-config-${UDEV_PV}.tar.bz2
		htmlsingle? ( ${MY_SRC}/LFS-BOOK-${PV}-NOCHUNKS.html.bz2 )
		pdf? ( ${MY_SRC}/LFS-BOOK-${PV}.pdf )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="htmlsingle pdf"

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack LFS-BOOK-${PV}-HTML.tar.bz2 \
		lfs-bootscripts-${BOOTSCRIPT_PV}.tar.bz2 \
		udev-config-${UDEV_PV}.tar.bz2

	use htmlsingle && unpack LFS-BOOK-${PV}-NOCHUNKS.html.bz2
	use pdf && cp "${DISTDIR}"/LFS-BOOK-${PV}.pdf "${S}"
}

src_install() {
	dodoc -r *
	docompress -x /usr/share/doc/${PF}
}
