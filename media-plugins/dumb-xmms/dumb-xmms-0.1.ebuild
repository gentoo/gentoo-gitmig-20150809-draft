# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/dumb-xmms/dumb-xmms-0.1.ebuild,v 1.1 2003/06/06 21:25:44 robh Exp $

DESCRIPTION="Plug-in for accurate, high-quality IT/XM/S3M/MOD playback."
HOMEPAGE="http://dumb.sourceforge.net/"
SRC_URI="mirror://sourceforge/dumb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=media-sound/xmms-1.2.7-r20
	>=media-libs/dumb-0.9.2"

S=${WORKDIR}/${PN}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/lib/xmms/Input
	make INSTALL_DIR=${D}/usr/lib/xmms/Input install || die
        einfo 'Open XMMS, and go to Options -> Preferences -> Audio I/O plugins.'
        einfo 'If "MikMod Player" is listed under "Input Plugins", click on it'
        einfo 'and uncheck "Enable Plugin". Do the same for any other plugins'
	einfo 'that play IT, XM, S3M and MOD files (e.g. ModPlugXMMS and XMP).'
        einfo 'If you have multiple plug-ins enabled for the same file formats,'
	einfo "it's anyone's guess which one XMMS will use."
	einfo 'DUMB-XMMS is rather lacking in GUI elements, but this will be'
	einfo 'much improved in the next version. Give it another try then!'
}
