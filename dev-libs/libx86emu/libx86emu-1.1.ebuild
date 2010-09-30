# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libx86emu/libx86emu-1.1.ebuild,v 1.1 2010/09/30 22:42:53 ssuominen Exp $

EAPI=2
inherit multilib rpm toolchain-funcs

DESCRIPTION="A library for emulating x86"
HOMEPAGE="http://www.opensuse.org/"
SRC_URI="http://download.opensuse.org/source/factory/repo/oss/suse/src/${P}-9.8.src.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_prepare() {
	sed -i \
		-e 's:$(CC) -shared:& $(LDFLAGS):' \
		Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -fPIC -Wall" || die
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install || die
	dodoc Changelog README
}
