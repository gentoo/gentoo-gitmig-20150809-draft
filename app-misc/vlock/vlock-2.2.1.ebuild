# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vlock/vlock-2.2.1.ebuild,v 1.1 2008/05/12 20:51:29 pva Exp $

inherit eutils pam toolchain-funcs

DESCRIPTION="A console screen locker"
HOMEPAGE="http://cthulhu.c3d2.de/~toidinamai/vlock/vlock.html"
SRC_URI="http://cthulhu.c3d2.de/~toidinamai/vlock/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="pam"

DEPEND="pam? ( sys-libs/pam )"

pkg_setup() {
	enewgroup vlock
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:LDFLAGS +=:LDLIBS +=:" Makefile # Fix --as-needed
	sed -i 's:$(LD):$(CC):' modules/Makefile # Fix --as-needed
}

src_compile() {
	if use pam; then
		myconf="--enable-pam"
	else
		myconf="--enable-shadow"
	fi
	# this package has handmade configure system which fails with econf...
	./configure --prefix=/usr \
				--mandir=/usr/share/man \
				${myconf} \
				CC="$(tc-getCC)" \
				LD="$(tc-getLD)" \
				CFLAGS="${CFLAGS} -pedantic -std=gnu99" \
				LDFLAGS="${LDFLAGS}" || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	use pam && pamd_mimic_system vlock auth
	dodoc ChangeLog PLUGINS README README.X11 SECURITY STYLE TODO
}
