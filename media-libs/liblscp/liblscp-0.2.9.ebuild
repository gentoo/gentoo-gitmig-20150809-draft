# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblscp/liblscp-0.2.9.ebuild,v 1.5 2005/07/31 21:19:02 swegener Exp $

DESCRIPTION="liblscp is a C++ library for the Linux Sampler control protocol."
HOMEPAGE="http://www.linuxsampler.org/"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RDEPEND="virtual/libc
	doc? ( app-doc/doxygen )"

DEPEND="${RDEPEND}"

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog INSTALL TODO NEWS README

	if use doc; then
		mv ${S}/doc/html ${D}/usr/share/doc/${PF}/
	fi
}
