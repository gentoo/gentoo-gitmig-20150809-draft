# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/videogen/videogen-0.32-r1.ebuild,v 1.1 2010/09/19 01:21:58 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Small utility to generate XFree86 modelines and fbset timings"
HOMEPAGE="http://www.dynaweb.hu/opensource/videogen/"
SRC_URI="http://www.dynaweb.hu/opensource/videogen/download/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_prepare() {
	# set LDFLAGS
	sed -i Makefile -e 's| -o | $(LDFLAGS)&|g' || die "sed Makefile"
}

src_compile() {
	# override CC/CFLAGS
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" || die "emake"
}

src_install() {
	dobin videogen || die
	doman videogen.1x
	dodoc BUGS CHANGES README THANKS videogen.sample
}
