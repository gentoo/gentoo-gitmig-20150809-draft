# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-volume/gkrellm-volume-2.1.13.ebuild,v 1.1 2005/03/22 18:04:18 sekretarz Exp $

IUSE="alsa"
DESCRIPTION="A mixer control plugin for gkrellm"
HOMEPAGE="http://gkrellm.luon.net/volume.phtml"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

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
	insinto /usr/lib/gkrellm2/plugins
	doins volume.so
	dodoc README Changelog
}
