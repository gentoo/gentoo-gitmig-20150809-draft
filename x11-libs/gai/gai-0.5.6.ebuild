# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gai/gai-0.5.6.ebuild,v 1.3 2006/12/01 22:53:25 masterdriverz Exp $

IUSE="opengl gnome"

MY_P=${P/_/}
DESCRIPTION="GAI, The General Applet Interface library is a library that will help applet programmers a lot."
HOMEPAGE="http://gai.sourceforge.net/"
SRC_URI="mirror://sourceforge/gai/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=x11-libs/gtk+-2.0.0
	opengl? ( >=x11-libs/gtkglext-1.0.5 )
	gnome? ( >=gnome-base/gnome-panel-2.0.0 )
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_compile() {
	# works with just set prefix (doesn't hardcode the prefix anywhere)!
	local myconf

	# Someone please tell upstream that the way to enable/disable things in
	# configure scripts should be bloody well consistent -- it's in poor taste
	# and downright incompetent to have to use --with if you want something
	# and --disable if you don't

	use opengl \
		&& myconf="${myconf} --with-gl" \
		|| myconf="${myconf} --disable-gl"

	use gnome \
		&& myconf="${myconf} --with-gnome" \
		|| myconf="${myconf} --disable-gnome"

	econf \
		--prefix=${D}/usr \
		${myconf} || die

	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS COPYING.LIB ChangeLog INSTALL README \
		README.gai THANKS TODO WINDOWMANAGERS
	dohtml ${S}/docs/*
	# install examples
	cp -r ${S}/examples ${D}/usr/share/doc/${P}
}
