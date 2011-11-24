# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/libewf/libewf-20100226-r1.ebuild,v 1.3 2011/11/24 22:31:42 radhermit Exp $

EAPI="4"

inherit autotools-utils

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://libewf.sourceforge.net"
SRC_URI="mirror://sourceforge/libewf/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
# upstream bug #2597171, pyewf has implicit declarations
#IUSE="debug python rawio unicode"
IUSE="debug ewf2 rawio static-libs unicode"

DEPEND="
	sys-libs/e2fsprogs-libs
	sys-libs/zlib
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		$(use_enable ewf2 v2-api) \
		$(use_enable rawio low-level-functions) \
		$(use_enable static-libs static) \
		$(use_enable unicode wide-character-type)
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README documents/*.txt
	doman manuals/*.1 manuals/*.3
	remove_libtool_files all
}
