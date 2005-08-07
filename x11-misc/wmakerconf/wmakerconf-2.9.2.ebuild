# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmakerconf/wmakerconf-2.9.2.ebuild,v 1.8 2005/08/07 13:24:52 hansmi Exp $

inherit eutils

DESCRIPTION="X based config tool for the windowmaker X windowmanager."
SRC_URI="http://www.starplot.org/wmakerconf/${P}.tar.gz"
HOMEPAGE="http://www.starplot.org/wmakerconf/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc sparc x86"

IUSE="nls gnome imlib perl"

DEPEND="=x11-libs/gtk+-1.2*
	x11-wm/windowmaker
	gnome? ( =gnome-base/gnome-libs-1.4* )
	imlib? ( media-libs/imlib )"

RDEPEND="nls? ( sys-devel/gettext )
	perl? ( dev-lang/perl
		net-misc/wget )"

src_compile() {
	local myconf

	use nls	|| myconf="${myconf} --disable-nls"
	use imlib || myconf="${myconf} --disable-imlibtest"
	use gnome || myconf="${myconf} --without-gnome"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} \
		GNOMEDIR=${D}/usr/share/gnome/apps/Settings \
		gnulocaledir=${D}/usr/share/locale \
		install || die "install failed"
	#	prefix=${D}/usr \
	#	install || die

	dodoc README MANUAL AUTHORS TODO COPYING ChangeLog
	#dohtml -r .
}

