# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/partimage/partimage-0.6.2.ebuild,v 1.4 2003/02/13 16:08:58 vapier Exp $

DESCRIPTION="Console-based application to efficiently save raw partition data to an image file. Optional encryption/compression support."
HOMEPAGE="http://www.partimage.org/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/partimage/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl"

RDEPEND="virtual/glibc
    >=sys-libs/zlib-1.1.4
    >=dev-libs/lzo-1.08
    >=dev-libs/newt-0.50.35-r1
    >=sys-libs/slang-1.4.5-r2
    ssl? ( >=dev-libs/openssl-0.9.6g )"

DEPEND="${RDEPEND} sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Patch Makefile.am so we can take over some of is install work
	#patch -p1 < ${FILESDIR}/${PF}-gentoo.patch || die "patch failed"
	autoconf
}

src_compile() {
    # SSL is optional
	local sslconf
	use ssl || sslconf="--disable-ssl"
	./configure \
		${sslconf} \
		--prefix=/usr \
		--infodir=/usr/share/doc/${PF} \
		--sysconfdir=/etc \
		--mandir=/usr/share/man || die "./configure failed"
	cp Makefile Makefile.orig
	sed -e "s/partimag\.root/root.root/g" Makefile.orig > Makefile
	emake || die
}

src_install() {
	make \
	prefix=${D}/usr \
	sysconfdir=${D}/etc \
	mandir=${D}/usr/share/man \
	infodir=${D}/usr/share/doc/${PF} \
	install || die
}
