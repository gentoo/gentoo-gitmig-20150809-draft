# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/flwm/flwm-1.00-r2.ebuild,v 1.9 2003/09/04 04:35:39 msterret Exp $

IUSE="opengl"

S=${WORKDIR}/${P}

SRC_URI="http://flwm.sourceforge.net/${P}.tgz"

HOMEPAGE="http://flwm.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"

DESCRIPTION="A lightweight window manager based on fltk"

DEPEND=">=x11-base/xfree-4.0.1
	>=x11-libs/fltk-1.0.11
	opengl? ( virtual/opengl )"

	#Configuration of the appearance and behavior of flwm
	#must be done at compile time, i.e. there is
	#no .flwmrc file or interactive configuring while
	#running. To quote the man page, "gcc is your friend,"
	#so this type of configuration must be done at compile
	#time by editing the config.h file.  I can't see any
	#way to do this automagically so we'll echo a message
	#in pkg_postinst to tell the user to 'ebuild unpack'
	#and edit the config.h to their liking.

src_compile() {

	use opengl && export X_EXTRA_LIBS=-lGL

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} || die "Configuration Failed"

	emake || die "Parallel Make Failed"
}

src_install() {

	doman flwm.1
	dodoc README flwm_wmconfig

	into /usr
	dobin flwm
}

pkg_postinst() {
	einfo "Customization of behaviour and appearance of"
	einfo "flwm requires manually editing the config.h"
	einfo "source file.  If you want to change the defaults,"
	einfo "do the following:"
	einfo ""
	einfo "\tebuild ${P}.ebuild unpack"
	einfo "\t${EDITOR} ${S}/config.h "
	einfo "\tebuild ${P} compile install qmerge"
}
