# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quirc/quirc-0.9.83-r1.ebuild,v 1.8 2004/09/01 02:35:17 swegener Exp $

inherit eutils

DESCRIPTION="A GUI IRC client scriptable in Tcl/Tk"
SRC_URI="http://quirc.org/${P}.tar.gz"
HOMEPAGE="http://quirc.org/"

DEPEND="<dev-lang/tcl-8.4
	<dev-lang/tk-8.4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff

}

src_compile() {

	export CXX="g++"

	econf \
		--datadir=/usr/share/quirc \
		|| die "./configure failed"

	emake || die

}

src_install () {

	exeinto /usr/bin
	doexe quirc

	insinto /usr/share/quirc
	doins data/*.tcl data/quedit data/fontsel data/servers data/VERSION

	insinto /usr/share/quirc/common
	doins ${S}/data/common/*.tcl

	insinto /usr/share/quirc/themes
	doins ${S}/data/themes/*.tcl

	# this package installs docs, but we would rather do that ourselves
	dodoc README NEWS INSTALL FAQ ChangeLog* COPYING AUTHORS
	dodoc doc/*.txt

}
