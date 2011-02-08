# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libixp/libixp-0.5_p20110208.ebuild,v 1.2 2011/02/08 18:27:11 ssuominen Exp $

# hg clone http://hg.suckless.org/libixp

EAPI=3
inherit multilib toolchain-funcs

DESCRIPTION="A stand-alone client/server 9P library including ixpc client"
HOMEPAGE="http://libs.suckless.org/libixp"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/xz-utils"

pkg_setup() {
	myixpconf=(
		PREFIX="/usr"
		LIBDIR="/usr/$(get_libdir)"
		CC="$(tc-getCC) -c"
		LD="$(tc-getCC) ${LDFLAGS}"
		AR="$(tc-getAR) crs"
		MAKESO="1"
		SOLDFLAGS="-shared -Wl,-soname"
		)
}

src_compile() {
	emake "${myixpconf[@]}" || die
}

src_install() {
	emake "${myixpconf[@]}" DESTDIR="${D}" install || die
	dolib.so lib/libixp{,_pthread}.so || die
	dodoc NEWS
}
