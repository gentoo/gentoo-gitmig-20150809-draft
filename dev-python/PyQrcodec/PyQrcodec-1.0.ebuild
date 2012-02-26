# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQrcodec/PyQrcodec-1.0.ebuild,v 1.5 2012/02/26 23:46:39 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.5"

inherit distutils eutils

DESCRIPTION="PyQrCodec is a Python module for encoding and decoding QrCode images."
HOMEPAGE="http://www.pedemonte.eu/pyqr/index.py/pyqrhome"
SRC_URI="http://www.pedemonte.eu/pyqr/files/${PN}_Linux.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/imaging
	media-libs/opencv"
RDEPEND="${DEPEND}"

S="${WORKDIR}/PyQrCodec"

PYTHON_MODNAME="PyQrcodec"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/opencv-2.0-compat.patch"
}
