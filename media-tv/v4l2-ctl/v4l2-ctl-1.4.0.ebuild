# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/v4l2-ctl/v4l2-ctl-1.4.0.ebuild,v 1.1 2010/05/21 01:51:35 beandog Exp $

EAPI=2

MY_PN="ivtv-utils"
MY_P="${MY_PN}-${PV}"

inherit eutils

DESCRIPTION="Small utlility to access and change settings on V4L2 devices"
HOMEPAGE="http://www.ivtvdriver.org"
SRC_URI="http://dl.ivtvdriver.org/ivtv/archive/1.4.x/${MY_P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="!<media-tv/ivtv-utils-1.4.0-r1"

S="${WORKDIR}/${MY_P}"

src_compile() {
	cd "${S}"/utils
	emake v4l2-ctl
}

src_install() {
	cd "${S}"
	dobin "utils/v4l2-ctl"

	dodoc doc/README.utils
}
