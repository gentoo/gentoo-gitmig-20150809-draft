# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-3.48.ebuild,v 1.3 2003/12/24 19:06:26 bazik Exp $

inherit gcc eutils

DESCRIPTION="utility for network exploration or security auditing"
SRC_URI="http://www.insecure.org/nmap/dist/${P}.tar.bz2
	http://www.packetstormsecurity.nl/UNIX/nmap/${PN}-3.20_statistics-1.diff"
HOMEPAGE="http://www.insecure.org/nmap/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc sparc ~alpha ~hppa ~mips ~amd64"
IUSE="gtk gnome"

DEPEND="virtual/glibc
	gtk? ( =x11-libs/gtk+-1.2* )"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${DISTDIR}/${PN}-3.20_statistics-1.diff
}

src_compile() {
	econf `use_with gtk nmapfe` || die
	emake || die
}

src_install() {
	einstall \
		nmapdatadir=${D}/usr/share/nmap \
		install \
		|| die
	use gnome || rm -rf ${D}/usr/share/gnome/

	dodoc CHANGELOG HACKING INSTALL docs/README docs/*.txt
	dohtml docs/*.html
}
