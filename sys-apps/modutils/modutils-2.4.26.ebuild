# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.26.ebuild,v 1.3 2003/12/17 04:50:48 brad_mssw Exp $

inherit flag-o-matic

DESCRIPTION="Standard kernel module utilities"
SRC_URI="mirror://kernel/linux/utils/kernel/${PN}/v2.4/${P}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/modutils/"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~arm ~mips ~ia64 ppc64"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
PROVIDE="virtual/modutils"

src_unpack() {
	unpack ${A}

	EPATCH_OPTS="-d ${S}/util" \
	epatch ${FILESDIR}/alias.h.diff
}

src_compile() {
	local myconf=
	local mymake=

	filter-flags -fPIC

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

	dodoc COPYING CREDITS ChangeLog NEWS README TODO
}

