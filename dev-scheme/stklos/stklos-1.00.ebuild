# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/stklos/stklos-1.00.ebuild,v 1.1 2010/10/06 03:15:06 chiiph Exp $

EAPI="3"

inherit eutils

DESCRIPTION="fast and light Scheme implementation"
HOMEPAGE="http://www.stklos.net"
SRC_URI="http://www.stklos.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="threads"

# stklos bundles libffi, libgmp and libpcre is no system one is available, enforcing dependencies
# PACKAGE-USED talks about boehm-gc 7.2alpha4, but 7.1 seems fine
# Other deps are set according to that file
DEPEND=">=dev-libs/boehm-gc-7.1[threads?]
		dev-libs/gmp
		dev-libs/libffi
		dev-libs/libpcre
"
RDEPEND="${DEPEND}"

# call/cc & dynamic-wind test fails on amd64. already upstream

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS PACKAGES-USED PORTING-NOTES README SUPPORTED-SRFIS \
		|| die "dodocs failed"
}
