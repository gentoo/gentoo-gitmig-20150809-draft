# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gentoo/gentoo-0.11.46.ebuild,v 1.1 2004/03/02 07:49:21 seemant Exp $

IUSE="nls gnome"

S=${WORKDIR}/${P}
DESCRIPTION="A modern GTK+ based filemanager for any WM"
SRC_URI="mirror://sourceforge/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.obsession.se/gentoo/"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"

src_compile() {

	econf \
		--sysconfdir=/etc/gentoo \
		`use_enable nls` || die

	emake || die
}

src_install() {
	einstall \
		sysconfdir=${D}/etc/gentoo || die

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
