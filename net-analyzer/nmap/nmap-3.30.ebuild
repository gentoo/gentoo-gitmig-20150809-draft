# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-3.30.ebuild,v 1.8 2004/01/20 19:52:13 spock Exp $

inherit gcc eutils

DESCRIPTION="utility for network exploration or security auditing"
SRC_URI="http://www.insecure.org/nmap/dist/${P}.tar.bz2
	http://www.packetstormsecurity.nl/UNIX/nmap/${PN}-3.20_statistics-1.diff"
HOMEPAGE="http://www.insecure.org/nmap/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE="gtk gnome"

DEPEND="virtual/glibc
	gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {
	epatch ${DISTDIR}/${PN}-3.20_statistics-1.diff
	# fix header
	if [ `gcc-major-version` -eq 3 ] ; then
		cp nbase/nbase.h nbase/nbase.h.old
		sed -e 's:char \*strcasestr://:' \
			nbase/nbase.h.old > nbase/nbase.h
	fi

	econf `use_with gtk nmapfe` || die
	emake || die
}

src_install() {
	einstall \
		nmapdatadir=${D}/usr/share/nmap \
		install \
		|| die
	use gnome || rm -rf ${D}/usr/share/gnome/

	dodoc CHANGELOG COPYING HACKING INSTALL README* docs/README docs/*.txt
	dohtml docs/*.html
}
