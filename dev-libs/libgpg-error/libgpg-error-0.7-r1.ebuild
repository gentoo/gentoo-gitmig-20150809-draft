# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgpg-error/libgpg-error-0.7-r1.ebuild,v 1.1 2004/09/21 08:36:23 dragonheart Exp $

inherit gnuconfig

DESCRIPTION="Contains error handling functions used by GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips ~alpha hppa ~amd64 ia64 ppc64"
IUSE="nls"

DEPEND="virtual/libc"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	# Needed for mips and probably others
	gnuconfig_update

	econf `use_enable nls` || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
