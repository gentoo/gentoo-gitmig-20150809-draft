# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.26.ebuild,v 1.13 2004/09/02 13:20:56 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="Standard kernel module utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/modutils/"
SRC_URI="mirror://kernel/linux/utils/kernel/${PN}/v2.4/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~mips alpha ~hppa -amd64 ia64 ppc64 s390"
IUSE=""

DEPEND="virtual/libc
	!virtual/modutils"
PROVIDE="virtual/modutils"

src_unpack() {
	unpack ${A}

	EPATCH_OPTS="-d ${S}/util" \
	epatch ${FILESDIR}/alias.h.diff
}

src_compile() {
	local myconf=
	local mymake=

	# see bug #3897 ... we need insmod static, as libz.so is in /usr/lib
	#
	# Final resolution ... dont make it link against zlib, as the static
	# version do not want to autoload modules :(
	myconf="${myconf} --disable-zlib"

	[ ${ARCH} = "hppa" ] && mymake="ARCH=hppa"

	econf \
		--prefix=/ \
		--disable-strip \
		--enable-insmod-static \
		${myconf} || die "./configure failed"

	emake ${mymake} || die "emake failed"
}

src_install() {
	local mymake=
	[ ${ARCH} = "hppa" ] && mymake="ARCH=hppa"
	einstall prefix="${D}" ${mymake} || die "make install failed"

	dodoc CREDITS ChangeLog NEWS README TODO
}
