# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/partimage/partimage-0.6.2.ebuild,v 1.16 2004/10/28 19:17:43 blubb Exp $

inherit gnuconfig

DESCRIPTION="Console-based application to efficiently save raw partition data to an image file. Optional encryption/compression support."
HOMEPAGE="http://www.partimage.org/"
SRC_URI="mirror://sourceforge/partimage/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="ssl"

RDEPEND="virtual/libc
	>=sys-libs/zlib-1.1.4
	>=dev-libs/lzo-1.08
	>=dev-libs/newt-0.50.35-r1
	>=sys-libs/slang-1.4.5-r2
	app-arch/bzip2
	ssl? ( >=dev-libs/openssl-0.9.6g )"

DEPEND="${RDEPEND} sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Patch Makefile.am so we can take over some of is install work
	#patch -p1 < ${FILESDIR}/${PF}-gentoo.patch || die "patch failed"
	autoconf

	gnuconfig_update
}

src_compile() {
	# SSL is optional
	local sslconf
	use ssl || sslconf="--disable-ssl"
	econf \
		${sslconf} \
		--infodir=/usr/share/doc/${PF} || die "econf failed"
	cp Makefile Makefile.orig
	sed -e "s/partimag\.root/root:root/g" Makefile.orig > Makefile
	emake || die
}

src_install() {
	make \
	prefix=${D}/usr \
	sysconfdir=${D}/etc \
	mandir=${D}/usr/share/man \
	infodir=${D}/usr/share/doc/${PF} \
	localedir=${D}/usr/share/locale \
	gettextsrcdir=${D}/usr/share/gettext/po \
	install || die
}
