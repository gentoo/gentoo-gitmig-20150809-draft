# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xlhtml/xlhtml-0.5.ebuild,v 1.1 2003/04/17 21:00:32 chouser Exp $

inherit gnuconfig

DESCRIPTION="Convert MS Excel and Powerpoint files to HTML"
HOMEPAGE="http://chicago.sourceforge.net/xlhtml/"
SRC_URI="mirror://sourceforge/chicago/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha"
IUSE=""
DEPEND=""

src_compile() {
	# This is needed specifically for depcomp, which is necessary for
	# building xlhtml, but isn't included.
	touch depcomp || die "Failed to create depcomp"
	gnuconfig_update config.sub config.guess depcomp

	econf || die "econf failed for ${P}"
	emake || die "emake failed for ${P}"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed for ${P}"
	dodoc AUTHORS
}
