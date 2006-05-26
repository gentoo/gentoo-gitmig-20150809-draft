# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libjit/libjit-0.0.4.ebuild,v 1.3 2006/05/26 16:50:04 antarus Exp $

DESCRIPTION="libjit implements Just-In-Time compilation functionality and is designed to be independent of any particular virtual machine bytecode format or language"
HOMEPAGE="http://www.southern-storm.com.au/libjit.html"
SRC_URI="http://www.southern-storm.com.au/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~arm ~amd64"
IUSE=""

DEPEND=""

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
