# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/v4l2-ctl/v4l2-ctl-1.4.0.ebuild,v 1.2 2010/08/09 07:47:21 xarthisius Exp $

EAPI=2

MY_PN=ivtv-utils
MY_P=${MY_PN}-${PV}

inherit eutils toolchain-funcs

DESCRIPTION="Small utlility to access and change settings on V4L2 devices"
HOMEPAGE="http://www.ivtvdriver.org"
SRC_URI="http://dl.ivtvdriver.org/ivtv/archive/1.4.x/${MY_P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="!<media-tv/ivtv-utils-1.4.0-r1"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-QA.patch
}

src_compile() {
	tc-export CXX CC
	emake -C utils v4l2-ctl || die
}

src_install() {
	dobin utils/v4l2-ctl || die
	dodoc doc/README.utils || die
}
