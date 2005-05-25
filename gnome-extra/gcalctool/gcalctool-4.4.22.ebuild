# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gcalctool/gcalctool-4.4.22.ebuild,v 1.7 2005/05/25 04:06:53 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="A scientific calculator for Gnome2"
HOMEPAGE="http://calctool.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2
	>=dev-libs/atk-1.6"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	app-text/scrollkeeper
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO MAINTAINERS"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-4.4.20-remove_disable_deprecated.patch

}

src_install() {

	gnome2_src_install

	# remove symlink that conflicts with <2.3 gnome-utils
	rm -f ${D}/usr/bin/gnome-calculator

}
