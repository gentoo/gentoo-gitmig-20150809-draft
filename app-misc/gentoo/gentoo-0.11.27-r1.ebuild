# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/gentoo/gentoo-0.11.27-r1.ebuild,v 1.2 2002/07/17 19:08:05 stroke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A modern GTK+ based filemanager for any WM"
SRC_URI="mirror://sourceforge/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.obsession.se/gentoo/"

DEPEND="=x11-libs/gtk+-1.2*"

RDEPEND="nls? ( sys-devel/gettext )"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

src_unpack() {

	unpack ${A}

	use nls && ( \
		cd ${S}/src
		cp gentoo.h gentoo.h.orig
		sed "s:#undef ENABLE_NLS:#define ENABLE_NLS:" \
			gentoo.h.orig > gentoo.h
	)
}

src_compile() {
	econf \
		--sysconfdir=/etc/gentoo || die "./configure failed"
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
