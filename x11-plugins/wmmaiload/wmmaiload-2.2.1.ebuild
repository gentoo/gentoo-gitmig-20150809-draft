# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmaiload/wmmaiload-2.2.1.ebuild,v 1.4 2008/01/12 01:04:26 coldwind Exp $

DESCRIPTION="dockapp that monitors one or more mailboxes."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
LICENSE="GPL-2"

RDEPEND="=x11-libs/gtk+-1*
	x11-libs/libXpm"
DEPEND="${RDEPEND}"

IUSE=""

src_compile() {
	./configure -p /usr || die "configure failed"

	# Let's wipe out those horrid defaults
	sed -e 's/^CFLAGS/#CFLAGS/' \
		-e 's/^CPPFLAGS/#CPPFLAGS/' \
		-e 's/^DEBUG_CFLAGS/#DEBUG_CFLAGS/' \
		-e 's/^DEBUG_CPPFLAGS/#DEBUG_CPPFLAGS/' \
		-e 's/^DEBUG_LDFLAGS/#DEBUG_LDFLAGS/' \
		-i wmmaiload/Makefile wmmaiload-config/Makefile

	emake || die "parallel make failed"
}

src_install () {
	dobin wmmaiload/wmmaiload wmmaiload-config/wmmaiload-config
	doman doc/wmmaiload.1 doc/wmmaiload-config.1
	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS TODO doc/sample.wmmailoadrc
}
