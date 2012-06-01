# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/sash/sash-3.7-r3.ebuild,v 1.3 2012/06/01 06:53:42 jdhore Exp $

EAPI="4"

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="A small (static) UNIX Shell"
HOMEPAGE="http://www.canb.auug.org.au/~dbell/ http://dimavb.st.simbirsk.su/vlk/"
SRC_URI="http://www.canb.auug.org.au/~dbell/programs/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE="static"

DEPEND="static? ( sys-libs/zlib[static-libs] )
	!static? ( >=sys-libs/zlib-1.2.3 )"
RDEPEND="!static? ( ${DEPEND} )"

src_prepare() {
	epatch "${FILESDIR}"/sash-3.7-builtin.patch

	sed -i \
		-e "s:-O3:${CFLAGS}:" \
		Makefile || die
}

src_compile() {
	use static && append-ldflags -static

	emake LDFLAGS="${LDFLAGS}" CC="$(tc-getCC)"
}

src_install() {
	into /
	dobin sash
	doman sash.1
	dodoc README
}
