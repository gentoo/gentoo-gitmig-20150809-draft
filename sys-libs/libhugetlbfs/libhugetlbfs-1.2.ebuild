# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libhugetlbfs/libhugetlbfs-1.2.ebuild,v 1.2 2008/03/20 15:07:06 vapier Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="easy hugepage access"
HOMEPAGE="http://libhugetlbfs.ozlabs.org/"
SRC_URI="http://libhugetlbfs.ozlabs.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^PREFIX/s:/local::' \
		-e '1iBUILDTYPE = NATIVEONLY' \
		-e '1iV = 1' \
		-e "/^LIB\(32\|64\)/s:=.*:= $(get_libdir):" \
		-e '/^CC\(32\|64\)/s:=.*:= $(CC):' \
		Makefile
}

src_compile() {
	tc-export AR CC
	emake libs || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc HOWTO NEWS README
}
