# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/gentoo/gentoo-0.11.30.ebuild,v 1.1 2002/07/21 16:54:19 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A modern GTK+ based filemanager for any WM"
SRC_URI="mirror://sourceforge/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.obsession.se/gentoo/"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	
	local myconf

	use nls || myconf="${myconf} --disable-nls"
	econf \
		--sysconfdir=/etc/gentoo \
		${myconf} || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	if use gnome ; then
		insinto /usr/share/pixmaps
		doins icons/gentoo.png
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/gentoo.desktop
	fi

	dodoc AUTHORS BUGS CONFIG-CHANGES COPYING CREDITS ChangeLog INSTALL \
		NEWS ONEWS README* TODO
	dodoc docs/FAQ docs/menus.txt

	dohtml docs/*.{html,css}
	dohtml -r docs/images
	dohtml -r docs/config

	doman docs/gentoo.1x

	docinto scratch
	dodoc docs/scratch/*
}
