# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/recode/recode-3.6.ebuild,v 1.17 2003/09/05 22:37:22 msterret Exp $

inherit flag-o-matic gcc
replace-flags "-march=pentium4" "-march=pentium3"

DESCRIPTION="Convert files between various character sets."
HOMEPAGE="http://www.gnu.org/software/recode/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"
IUSE="nls"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""
	use nls || myconf="--disable-nls"

	# gcc-3.2 crashes if we don't remove any -O?
	if [ ! -z "`gcc-version`" == "3.2" ] && [ ${ARCH} == "x86" ] ; then
		filter-flags -O?
	fi
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
