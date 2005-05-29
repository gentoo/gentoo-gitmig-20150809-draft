# Copyright 2005-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblscp/liblscp-0.2.9.ebuild,v 1.1 2005/05/29 23:25:56 fvdpol Exp $

inherit eutils

DESCRIPTION="liblscp is a C++ library for the Linux Sampler control protocol."
HOMEPAGE="http://www.linuxsampler.org/"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RDEPEND="
	doc? ( app-doc/doxygen )"

DEPEND="${RDEPEND}"

src_compile() {
	econf || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog INSTALL TODO NEWS README

	if use doc; then
		mv ${S}/doc/html ${D}/usr/share/doc/${PF}/
	fi
}
