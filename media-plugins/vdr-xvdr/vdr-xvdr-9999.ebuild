# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-xvdr/vdr-xvdr-9999.ebuild,v 1.3 2011/09/17 15:13:44 hd_brummy Exp $

EAPI=2

inherit vdr-plugin git-2

EGIT_REPO_URI="git://github.com/pipelka/vdr-plugin-xvdr.git"

DESCRIPTION="VDR plugin: XVDR Streamserver Plugin"
HOMEPAGE="https://github.com/pipelka/vdr-plugin-xvdr"
SRC_URI=""
KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-1.6"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-plugin

src_prepare() {
	vdr-plugin_src_prepare

	fix_vdr_libsi_include recplayer.c
	fix_vdr_libsi_include receiver.c
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/xvdr
	doins xvdr/allowed_hosts.conf
	diropts -gvdr -ovdr
}
