# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cabextract/cabextract-1.2.ebuild,v 1.4 2007/04/01 07:36:08 vapier Exp $

DESCRIPTION="Extracts files from Microsoft .cab files"
HOMEPAGE="http://www.kyz.uklinux.net/cabextract.php"
SRC_URI="http://www.kyz.uklinux.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO doc/magic
	dohtml doc/wince_cab_format.html
}
