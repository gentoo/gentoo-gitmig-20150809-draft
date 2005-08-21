# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/picp/picp-0.6.7.ebuild,v 1.1 2005/08/21 11:45:48 dragonheart Exp $

inherit toolchain-funcs

DESCRIPTION="A commandline interface to Microchip's PICSTART+ programmer."
HOMEPAGE="http://home.pacbell.net/theposts/picmicro/"
SRC_URI="http://home.pacbell.net/theposts/picmicro/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake CC=$(tc-getCC) OPTIONS="${CFLAGS} -x c++" || die "emake failed"
	emake -C picsnoop CC=$(tc-getCC) OPTIONS="${CFLAGS} -x c++" || die "emake failed"
	emake -C fixchksum CC=$(tc-getCC) OPTIONS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodoc README HISTORY LICENSE.TXT NOTES PSCOMMANDS.TXT BugReports.txt TODO
	dohtml PICPmanual.html
	dobin picp
	dobin picsnoop/picsnoop
	dobin fixchksum/fixchksum
	newdoc picsnoop/README.TXT PICSNOOP.txt
	newdoc fixchksum/README fixchksum.txt
}
