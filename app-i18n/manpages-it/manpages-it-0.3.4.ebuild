# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-it/manpages-it-0.3.4.ebuild,v 1.1 2004/06/17 18:10:28 lu_zero Exp $

S=${WORKDIR}/${MY_P}
DESCRIPTION="A somewhat comprehensive collection of Italian Linux man pages"
SRC_URI="http://ftp.pluto.it/pub/pluto/ildp/man/man-pages-it-${PV}.tar.gz"
HOMEPAGE="http://it.tldp.org/man/"

LICENSE="LDP-1a"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc alpha hppa"

DEPEND="app-arch/gzip"
RDEPEND="sys-apps/man"

src_compile() {
	for x in man?
	do
		gzip ${S}/${x}/* || die
	done
}

src_install() {
	for x in man?
	do
		dodir /usr/share/man/it/${x}
		install -m 644 ${S}/${x}/* ${D}/usr/share/man/it/${x}
	done
}
