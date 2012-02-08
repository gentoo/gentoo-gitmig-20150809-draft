# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eeze/eeze-1.1.0.ebuild,v 1.1 2012/02/08 21:24:37 tommy Exp $

inherit enlightenment

DESCRIPTION="library to simplify the use of devices"
HOMEPAGE="http://trac.enlightenment.org/e/wiki/Eeze"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="static-libs utilities"

DEPEND=">=dev-libs/ecore-1.0.0_beta"
RDEPEND=${DEPEND}

src_configure() {
	MY_ECONF="
	$(use_enable utilities eeze-disk-ls)
	$(use_enable utilities eeze-mount)
	$(use_enable utilities eeze-umount)
	$(use_enable utilities eeze-udev-test)
	"

	enlightenment_src_configure
}
