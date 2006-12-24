# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-volume/gkrellm-volume-2.1.13.ebuild,v 1.3 2006/12/24 21:54:10 hansmi Exp $

inherit multilib

IUSE="alsa"
DESCRIPTION="A mixer control plugin for gkrellm"
HOMEPAGE="http://gkrellm.luon.net/volume.phtml"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ppc ~sparc x86"

DEPEND="=app-admin/gkrellm-2*
	alsa? ( media-libs/alsa-lib )"

S=${WORKDIR}/${PN}

src_compile() {
	if use alsa
	then
		make enable_alsa=1 || die "make failed"
	else
		make || die "make failed"
	fi
}

src_install() {
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins volume.so
	dodoc README Changelog
}
