# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/bookview/bookview-3.2.ebuild,v 1.1 2003/09/02 17:47:46 usata Exp $

inherit eutils

IUSE="cjk"

DESCRIPTION="NDTP client written in Tcl/Tk"
HOMEPAGE="http://www.sra.co.jp/people/m-kasahr/bookview/"
SRC_URI="ftp://ftp.sra.co.jp/pub/net/ndtp/bookview/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4"
RDEPEND=">=dev-lang/tk-8.3
	net-misc/ndtpd"

S=${WORKDIR}/${P}

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {

	econf `use_enable cjk ja-doc` || die
	emake || die
}

src_install() {

	einstall || die

	insinto /etc/X11/app-defaults
	newins ${FILESDIR}/Bookview.ad Bookview

	dodoc AUTHORS ChangeLog* INSTALL NEWS README
	use cjk && dodoc INSTALL-ja README-ja
}
