# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-sndfile/xmms-sndfile-1.2-r1.ebuild,v 1.1 2004/10/19 23:24:06 eradicator Exp $

IUSE=""

inherit xmms-plugin

MY_PN=${PN/-/_}
MY_P="${MY_PN}-${PV}"
XMMS_S="${XMMS_WORKDIR}/${MY_P}"
BMP_S="${BMP_WORKDIR}/${MY_P}"

DESCRIPTION="Xmms_sndfile is a libsndfile plugin for XMMS"
HOMEPAGE="http://www.mega-nerd.com/xmms_sndfile/"
SRC_URI="http://www.mega-nerd.com/xmms_sndfile/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

DEPEND="media-libs/libsndfile"

DOCS="AUTHORS NEWS README ChangeLog TODO"

src_install() {
	myins_xmms="libdir=`xmms-config --input-plugin-dir`"
	myins_bmp="libdir=`beep-config --input-plugin-dir`"

	xmms-plugin_src_install
}
