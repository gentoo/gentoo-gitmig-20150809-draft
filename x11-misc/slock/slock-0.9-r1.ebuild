# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/slock/slock-0.9-r1.ebuild,v 1.3 2012/02/02 17:04:18 jer Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="simple X screen locker"
HOMEPAGE="http://tools.suckless.org/slock"
SRC_URI="http://code.suckless.org/dl/tools/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND=${DEPEND}

src_prepare() {
	sed -i config.mk \
		-e '/^CFLAGS/{s: -Os::g; s:= :+= :g}' \
		-e '/^CC/d' \
		-e '/^LDFLAGS/{s:-s::g; s:= :+= :g}' \
		|| die
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
