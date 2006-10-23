# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/bk_edit/bk_edit-0.6.23.ebuild,v 1.2 2006/10/23 22:10:27 kloeri Exp $

inherit eutils
DESCRIPTION="bk_edit is an easy to use bookmark manager and editor."
HOMEPAGE="http://www.allesdurcheinander.de/nettools/bk_edit/"
SRC_URI="http://www.allesdurcheinander.de/nettools/bk_edit/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-devel/flex
		sys-devel/bison
		>=x11-libs/gtk+-1.2.0
		>=dev-libs/libxml2-2.4.1"

cflags_replace() {
	for files in *
	do
		if [ -d $files ]
		then
			sed -e "s:^CFLAGS\s*=\s*:CFLAGS = ${CFLAGS} :" -i $files/Makefile
		fi
	done
}

src_compile() {
	econf || die "Configuration failed!"

	#fixes makefile against sandboxing
	epatch ${FILESDIR}/${P}-sandbox.patch

	#custom CFLAGS for main src
	cflags_replace

	#custom CFLAGS for the plugins too
	cd ${S}/src/plugins
	cflags_replace

	cd ${S}

	emake || die "Make failed!"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog INSTALL README
}
