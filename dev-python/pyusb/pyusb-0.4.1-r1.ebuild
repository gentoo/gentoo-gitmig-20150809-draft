# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyusb/pyusb-0.4.1-r1.ebuild,v 1.1 2009/05/28 21:05:57 josejx Exp $

inherit distutils flag-o-matic

DESCRIPTION="USB support for Python."
HOMEPAGE="http://pyusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

EAPI="1"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc"
IUSE="debug"

### The bus enumeration does not appear to work with libusb-compat
### A new version based on libusb-1.x is in the works, but not yet released
DEPEND="dev-libs/libusb:0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use debug; then
		append-flags -DNDEBUG
	fi
}
