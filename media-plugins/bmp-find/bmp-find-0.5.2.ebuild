# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-find/bmp-find-0.5.2.ebuild,v 1.3 2005/03/26 23:17:36 marineam Exp $

IUSE=""

MY_P=${P/bmp-/beep}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Beepfind is a BMP plugin to allow regexp searching, enqueuing and playing of files"
HOMEPAGE="http://xmmsfind.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmmsfind/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-sound/beep-media-player"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	plugin_install_dir="${D}$(pkg-config bmp --variable=general_plugin_dir)"
	make \
		PLUGIN_INSTALL_DIR=${plugin_install_dir} \
		REMOTE_INSTALL_DIR=${D}usr/bin install || die "install failed"

	dodoc BUGS COPYING INSTALL README TODO VERSION
}
