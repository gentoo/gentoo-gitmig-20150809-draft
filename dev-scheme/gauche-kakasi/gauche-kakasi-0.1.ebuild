# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-kakasi/gauche-kakasi-0.1.ebuild,v 1.3 2006/04/22 15:22:12 hattya Exp $

IUSE=""

MY_P="${P/g/G}"

DESCRIPTION="Kakasi binding for Gauche"
HOMEPAGE="http://gauche.sf.net/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-lang/gauche-0.8
	>=app-i18n/kakasi-2.3.4"

src_compile() {

	econf || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog README*

}
