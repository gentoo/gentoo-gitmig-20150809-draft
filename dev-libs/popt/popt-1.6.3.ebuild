# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/popt/popt-1.6.3.ebuild,v 1.19 2004/06/24 23:31:25 agriffis Exp $

IUSE="nls"

DESCRIPTION="Parse Options - Command line parser"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.0.x/${P}.tar.gz"
HOMEPAGE="http://www.rpm.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha mips hppa"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls || myconf="$myconf --disable-nls"

	econf ${myconf} || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc CHANGES COPYING README
}
