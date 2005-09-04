# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblscp/liblscp-0.3.0.ebuild,v 1.4 2005/09/04 12:30:45 flameeyes Exp $

DESCRIPTION="liblscp is a C++ library for the Linux Sampler control protocol."
HOMEPAGE="http://www.linuxsampler.org/"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
RDEPEND="virtual/libc"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog TODO NEWS README

	if use doc; then
		mv ${S}/doc/html ${D}/usr/share/doc/${PF}/
	fi
}
