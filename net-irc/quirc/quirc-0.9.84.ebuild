# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quirc/quirc-0.9.84.ebuild,v 1.2 2004/09/12 15:54:06 swegener Exp $

DESCRIPTION="A GUI IRC client scriptable in Tcl/Tk"
SRC_URI="http://quirc.org/${P}.tar.gz"
HOMEPAGE="http://quirc.org/"

DEPEND="dev-lang/tcl
	dev-lang/tk"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_compile() {
	export CXX="g++"

	econf \
		--datadir=/usr/share/quirc \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install () {
	dodbin quirc

	insinto /usr/share/quirc
	doins data/*.tcl data/quedit data/fontsel data/servers data/VERSION

	insinto /usr/share/quirc/common
	doins ${S}/data/common/*.tcl

	insinto /usr/share/quirc/themes
	doins ${S}/data/themes/*.tcl

	# this package installs docs, but we would rather do that ourselves
	dodoc README NEWS INSTALL FAQ ChangeLog* COPYING AUTHORS doc/*.txt
}
