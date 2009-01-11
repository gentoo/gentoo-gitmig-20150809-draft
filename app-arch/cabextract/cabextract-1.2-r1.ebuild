# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cabextract/cabextract-1.2-r1.ebuild,v 1.1 2009/01/11 16:12:23 pva Exp $

DESCRIPTION="Extracts files from Microsoft .cab files"
HOMEPAGE="http://www.cabextract.org.uk/"
SRC_URI="http://www.kyz.uklinux.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="extra-tools"

RDEPEND="extra-tools? ( dev-lang/perl )"

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO doc/magic
	dohtml doc/wince_cab_format.html
	if use extra-tools; then
		dobin src/{wince_info,wince_rename,cabinfo} || die
	fi
}
