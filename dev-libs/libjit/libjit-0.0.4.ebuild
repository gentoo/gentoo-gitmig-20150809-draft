# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libjit/libjit-0.0.4.ebuild,v 1.1 2004/08/08 07:28:08 scandium Exp $

DESCRIPTION="libjit implements Just-In-Time compilation functionality and is designed to be independent of any particular virtual machine bytecode format or language"
HOMEPAGE="http://www.southern-storm.com.au/libjit.html"
SRC_URI="http://www.southern-storm.com.au/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64 ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390"

IUSE=""

DEPEND=""

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
