# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/recode/recode-3.6-r1.ebuild,v 1.9 2004/06/28 03:28:53 ciaranm Exp $

inherit flag-o-matic base eutils gcc

DESCRIPTION="Convert files between various character sets."
HOMEPAGE="http://www.gnu.org/software/recode/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-debian.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64 alpha ia64 mips"
IUSE="nls"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-debian.diff
}

src_compile() {
	local myconf=""
	use nls || myconf="--disable-nls"

	# gcc-3.2 crashes if we don't remove any -O?
	if [ "`gcc-version`" == "3.2" ] && [ ${ARCH} == "x86" ] ; then
		filter-flags -O?
	fi

	replace-flags "-march=pentium4" "-march=pentium3"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		$myconf || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS BACKLOG COPYING* ChangeLog INSTALL
	dodoc NEWS README THANKS TODO
}
