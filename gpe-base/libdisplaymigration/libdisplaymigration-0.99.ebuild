# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libdisplaymigration/libdisplaymigration-0.99.ebuild,v 1.1 2009/03/06 17:53:43 solar Exp $

inherit gpe

DESCRIPTION="Gtk+ display migration library"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE}"
GPE_DOCS=""

src_install() {
	gpe_src_install "$@"
	make DESTDIR="${D}" PREFIX=/usr install-devel
}

RDEPEND="${RDEPEND}
	>=x11-libs/gtk+-2.6.3
	>=dev-libs/libgcrypt-1.2.1"

DEPEND="${DEPEND}
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e s/'install -s'/'install'/ Makefile || die
}
