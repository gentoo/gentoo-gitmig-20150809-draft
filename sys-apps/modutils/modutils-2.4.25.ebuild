# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.25.ebuild,v 1.25 2004/09/02 13:20:56 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Standard kernel module utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/modutils/"
SRC_URI="mirror://kernel/linux/utils/kernel/${PN}/v2.4/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -amd64 ppc sparc alpha hppa mips ia64"
IUSE=""

DEPEND="virtual/libc
	!virtual/modutils"
PROVIDE="virtual/modutils"

src_unpack() {
	unpack ${A}
	cd ${S}/util
	cat ${FILESDIR}/alias.h.diff | patch -p0 || die
}

src_compile() {
	filter-flags -fPIC

	myconf=""
	# see bug #3897 ... we need insmod static, as libz.so is in /usr/lib
	#
	# Final resolution ... dont make it link against zlib, as the static
	# version do not want to autoload modules :(
	myconf="${myconf} --disable-zlib"

	econf \
		--prefix=/ \
		--disable-strip \
		--enable-insmod-static \
		${myconf} || die "./configure failed"
	if [ ${ARCH} = "hppa" ]
	then
		mymake="ARCH=hppa"
	fi

	emake ${mymake} || die "emake failed"
}

src_install() {
	if [ ${ARCH} = "hppa" ]
	then
		mymake="ARCH=hppa"
	fi
	einstall prefix="${D}" ${mymake} || die "make install failed"

	dodoc CREDITS ChangeLog NEWS README TODO
}
