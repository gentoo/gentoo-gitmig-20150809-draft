# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quirc/quirc-0.9.84.ebuild,v 1.3 2004/11/13 00:23:01 swegener Exp $

DESCRIPTION="A GUI IRC client scriptable in Tcl/Tk"
SRC_URI="http://quirc.org/${P}.tar.gz"
HOMEPAGE="http://quirc.org/"

DEPEND="dev-lang/tcl
	dev-lang/tk"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

src_compile() {
	econf \
		--datadir=/usr/share/quirc \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install () {
	dobin quirc || die "dobin failed"

	insinto /usr/share/quirc
	doins data/*.tcl data/quedit data/fontsel data/servers data/VERSION \
		|| die "doins failed"

	insinto /usr/share/quirc/common
	doins ${S}/data/common/*.tcl || die "doins failed"

	insinto /usr/share/quirc/themes
	doins ${S}/data/themes/*.tcl || die "doins failed"

	# this package installs docs, but we would rather do that ourselves
	dodoc README NEWS INSTALL FAQ ChangeLog* COPYING AUTHORS doc/*.txt \
		|| die "dodoc failed"
}
