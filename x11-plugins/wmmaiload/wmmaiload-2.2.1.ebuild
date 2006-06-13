# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmaiload/wmmaiload-2.2.1.ebuild,v 1.1 2006/06/13 18:11:13 s4t4n Exp $

DESCRIPTION="dockapp that monitors one or more mailboxes."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-1.2.10-r11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.1.4-r1"

IUSE=""

src_compile() {
	./configure -p /usr || die "configure failed"

	# Let's wipe out those horrid defaults
	for file in "wmmaiload/Makefile wmmaiload-config/Makefile"
	do
		sed -i 's/^CFLAGS/#CFLAGS/' ${file}
		sed -i 's/^CPPFLAGS/#CPPFLAGS/' ${file}
		sed -i 's/^DEBUG_CFLAGS/#DEBUG_CFLAGS/' ${file}
		sed -i 's/^DEBUG_CPPFLAGS/#DEBUG_CPPFLAGS/' ${file}
		sed -i 's/^DEBUG_LDFLAGS/#DEBUG_LDFLAGS/' ${file}
	done

	emake || die "parallel make failed"
}

src_install () {
	dobin wmmaiload/wmmaiload wmmaiload-config/wmmaiload-config
	doman doc/wmmaiload.1 doc/wmmaiload-config.1
	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS TODO doc/sample.wmmailoadrc
}
