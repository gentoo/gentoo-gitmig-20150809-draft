# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfire/wmfire-0.0.3.9_pre4.ebuild,v 1.11 2007/07/22 05:09:22 dberkholz Exp $

IUSE=""

MY_P="${P/_/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="WindowMaker dockapp that displays cpu usage as a dancing flame"
SRC_URI="http://staff.xmms.org/zinx/misc/${MY_P}.tar.gz"
HOMEPAGE="http://staff.xmms.org/zinx/misc"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc ~sparc"

src_compile() {

	local myconf="--with-x";
	econf ${myconf} || die "configure failed"

	emake CFLAGS="$CFLAGS"  || die "parallel make faile"

}

src_install () {

	make install \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib || die

	dodoc AUTHORS CREDITS NEWS README

}
