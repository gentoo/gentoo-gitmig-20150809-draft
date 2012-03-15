# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/compton/compton-0_pre20120316.ebuild,v 1.1 2012/03/15 23:50:37 ssuominen Exp $

EAPI=4

unset _live_inherits

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="git://github.com/chjj/compton.git"
	_live_inherits="git-2"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"
fi

inherit toolchain-funcs ${_live_inherits}

DESCRIPTION="A compositor for X, and a fork of xcompmgr-dana"
HOMEPAGE="http://github.com/chjj/compton"

LICENSE="MIT"
SLOT="0"
IUSE=""

COMMON_DEPEND="x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrender"
RDEPEND="${COMMON_DEPEND}
	app-shells/bash
	x11-apps/xprop
	x11-apps/xwininfo"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	x11-proto/xproto"

src_prepare() {
	sed -i \
		-e '/^CFLAGS/s/=/+=/' \
		-e '/$(LIBS)$/s/$(CC)/$(CC) $(LDFLAGS)/' \
		-e 's/`pkg-config --libs $(PACKAGES)`/$(shell pkg-config --libs $(PACKAGES))/' \
		-e 's/`pkg-config --cflags $(PACKAGES)`/$(shell pkg-config --cflags $(PACKAGES))/' \
		Makefile || die
}

src_compile() {
	tc-export CC
	emake
}

src_install() {
	dobin ${PN} bin/settrans
	doman man/${PN}.1
	dodoc README.md
}
