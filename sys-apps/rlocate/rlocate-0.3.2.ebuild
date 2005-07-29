# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rlocate/rlocate-0.3.2.ebuild,v 1.2 2005/07/29 10:42:20 dholm Exp $

inherit eutils linux-mod

DESCRIPTION="locate implementation that is always up-to-date"
HOMEPAGE="http://rlocate.sourceforge.net/"
SRC_URI="mirror://sourceforge/rlocate/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="!sys-apps/slocate"

pkg_setup() {
	MODULE_NAMES="rlocate(misc:${S}/rlocate-module)"
	CONFIG_CHECK="SECURITY"
	SECURITY_ERROR="You need to select the \"Enable different security models\" option in the kernel configuration (CONFIG_SECURITY)."
	BUILD_TARGETS="all"
	linux-mod_pkg_setup

	enewgroup locate
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^RLOCATE_GRP/s:=.*:=locate:' \
		-e 's/rlocate-module//g' \
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
	econf --enable-sandboxed --with-kernel=${KV_DIR} || die
	emake || die
	linux-mod_src_compile
}

src_install() {
	make install DESTDIR="${D}" || die
	linux-mod_src_install
	dodoc AUTHORS ChangeLog* NEWS README
}
