# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-gui/gnustep-gui-0.8.8.ebuild,v 1.3 2004/02/07 01:00:53 agriffis Exp $

IUSE=""

inherit gnustep

DESCRIPTION="GNUstep AppKit implementation"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND=">=dev-util/gnustep-base-1.7.2
	>=media-libs/tiff-3.5.7
	>=media-libs/jpeg-6b-r2"
PDEPEND="=dev-util/gnustep-back-${PV}*"

S=${WORKDIR}/${P}

src_compile() {
	egnustepmake \
		--with-jpeg-library=/usr/lib \
		--with-jpeg-include=/usr/include \
		--with-tiff-library=/usr/lib \
		--with-tiff-include=/usr/include \
		|| die "configure failed"
}
