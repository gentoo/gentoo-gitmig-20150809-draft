# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rlocate/rlocate-0.3.0.ebuild,v 1.5 2005/07/20 00:16:35 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="locate implementation that is always up-to-date"
HOMEPAGE="http://rlocate.sourceforge.net/"
SRC_URI="mirror://sourceforge/rlocate/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND="!sys-apps/slocate"

pkg_setup() {
	enewgroup locate
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^RLOCATE_GRP/s:=.*:=locate:' \
		Makefile.in || die "sed group"
	rm -f rlocate-scripts/Makefile
	sed -i \
		-e '/groupadd/d' \
		-e '/chown/s/root:$(rlocate)/root:locate/g' \
		Makefile.in rlocate-scripts/Makefile.in
	sed -i \
		-e '/DRLOCATE_GRP/s:$(rlocate):locate:' \
		rlocate-daemon/Makefile.in
}

src_compile() {
	econf --enable-sandboxed || die
	ARCH=$(tc-arch-kernel) emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog* NEWS README
}
