# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lsat/lsat-0.8.1.ebuild,v 1.2 2003/10/27 10:27:45 aliz Exp $

DESCRIPTION="The Linux Security Auditing Tool"
HOMEPAGE="http://usat.sourceforge.net/"
SRC_URI="http://usat.sourceforge.net/code/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	dev-lang/perl"

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake all manpage || die
}

src_install() {
	dobin lsat
	doman lsat.1
	dodoc INSTALL README* changelog securitylinks.txt
	dohtml modules.html changelog/changelog.html

}
