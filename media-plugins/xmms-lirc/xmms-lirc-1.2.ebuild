# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-lirc/xmms-lirc-1.2.ebuild,v 1.7 2004/03/26 22:03:40 eradicator Exp $

MY_P=${P/xmms-lirc/lirc-xmms-plugin}

DESCRIPTION="LIRC plugin for xmms to control xmms with your favourite remote control."
HOMEPAGE="http://xmms.org/comments.php?show=P36"
SRC_URI="mirror://sourceforge/lirc/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="media-sound/xmms
	app-misc/lirc
	=x11-libs/gtk+-1.2*"
S=${WORKDIR}/${MY_P}

#src_compile() {
#	./configure \
#		--host=${CHOST} \
#		--prefix=/usr \
#		--infodir=/usr/share/info \
#		--mandir=/usr/share/man || die "./configure failed"
#	emake || die
#}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL lircrc NEWS README

}

pkg_postinst () {
	einfo
	einfo "You have to edit your .lircrc. You can find an example file at"
	einfo "/usr/share/doc/xmms-lirc-${PV}."
	einfo "And take a look at the README there."
	einfo
}
