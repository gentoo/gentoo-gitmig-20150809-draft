# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/devilspie/devilspie-0.16.ebuild,v 1.4 2006/04/16 22:58:11 hansmi Exp $

inherit eutils

DESCRIPTION="A Window Matching utility similar to Sawfish's Matched Windows feature"
HOMEPAGE="http://www.burtonini.com/blog/computers/devilspie"
SRC_URI="http://www.burtonini.com/computing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~sparc x86"

IUSE=""

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.0
	>=x11-libs/libwnck-2.10"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.20
	sys-devel/gettext"

src_unpack() {

	unpack "${A}"

	cd "${S}"
	sed -i "s:\(/usr/share/doc/devilspie\):\1-${PVR}:" devilspie.1 \
		|| die "Failed to sed manpage."

	epatch "${FILESDIR}/${P}-README.patch"
	cp "${FILESDIR}/SYNTAX-${PV}" SYNTAX

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS SYNTAX TODO
	keepdir /etc/devilspie

}

pkg_postinst() {

	ewarn
	ewarn "Devilspie has been completely rewritten for version 0.16 and is"
	ewarn "not backward compatible with previous versions."
	ewarn "You will now have to write some s-expressions files"
	ewarn "(like in Emacs), and put them either in /etc/devilspie for"
	ewarn "system-wide configuration, or in ~/.devilspie for per-user"
	ewarn "configuration."
	ewarn
	ewarn "See /usr/share/doc/${PF}/{README,SYNTAX}.gz for details."
	ewarn

}
