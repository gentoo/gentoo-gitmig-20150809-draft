# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cabextract/cabextract-1.3.ebuild,v 1.5 2010/07/31 17:26:53 jer Exp $

DESCRIPTION="Extracts files from Microsoft .cab files"
HOMEPAGE="http://www.cabextract.org.uk/"
SRC_URI="http://www.cabextract.org.uk/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
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
