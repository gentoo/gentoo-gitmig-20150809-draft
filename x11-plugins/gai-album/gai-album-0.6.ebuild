# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gai-album/gai-album-0.6.ebuild,v 1.4 2004/09/02 18:22:39 pvdabeel Exp $

MY_PV="${PV}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Displays the CD cover of the album that XMMS is playing"
HOMEPAGE="http://gai.sourceforge.net/"
SRC_URI="mirror://sourceforge/gai/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""
DEPEND=">=x11-libs/gai-0.5.3
	>=media-sound/xmms-1.2.10"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf ${MY_CONF} || die
	# fixing install location for ROX panel stuff
	# if this doesn't work as expected please report a bug at bugs.gentoo.org
	mv ${S}/Makefile ${S}/Makefile.orig
	sed s%\"/usr/share%\"${D}/usr/share%g ${S}/Makefile.orig > ${S}/Makefile
	emake || die
}

src_install() {
	# small hack so the gnome stuff gets installed in place
	mv ${S}/Makefile ${S}/Makefile.orig
	sed s%"GNOMEDIR = /usr"%"GNOMEDIR = ${D}/usr"% ${S}/Makefile.orig > ${S}/Makefile
	einstall || die
	dodoc BUGS COPYING CHANGES INSTALL README README.gai TODO ALBUMART xmms-song-change.sh
}
