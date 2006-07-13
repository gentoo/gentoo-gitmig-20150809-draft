# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-libsynce/synce-libsynce-0.9.2.ebuild,v 1.1 2006/07/13 21:25:07 liquidx Exp $

inherit eutils

DESCRIPTION="Common Library for Synce (connecting WinCE devices to Linux)"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="" # dbus

DEPEND=">=dev-libs/check-0.8.3.1"
#	dbus? ( sys-apps/dbus )"

S=${WORKDIR}/libsynce-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.9.1-amd64.patch
	sed -i -e 's/#include <slang.h>/#ifndef offsetof\n#define offsetof(T,F) ((unsigned int)((char *)\&((T *)0L)->F - (char *)0L))\n#endif/' lib/synce_socket.c
}

src_compile() {
	# dbus support not quite there yet.
	econf # $(use_enable dbus)
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
