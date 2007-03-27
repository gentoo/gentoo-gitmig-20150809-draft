# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libebml/libebml-0.7.7-r1.ebuild,v 1.9 2007/03/27 17:33:28 aballier Exp $

inherit multilib toolchain-funcs

DESCRIPTION="Extensible binary format library (kinda like XML)"
HOMEPAGE="http://www.matroska.org/"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ppc ~ppc-macos ppc64 sparc x86"
IUSE=""

S="${S}/make/linux"

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	einstall libdir="${D}/usr/$(get_libdir)" || die "make install failed"
	dodoc "${WORKDIR}/${P}/ChangeLog"
}
