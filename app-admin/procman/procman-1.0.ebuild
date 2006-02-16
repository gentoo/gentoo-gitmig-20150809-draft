# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/procman/procman-1.0.ebuild,v 1.26 2006/02/16 23:48:11 flameeyes Exp $

inherit flag-o-matic eutils

DESCRIPTION="Process viewer for GNOME"
HOMEPAGE="http://directory.fsf.org/sysadmin/monitor/procman.html"
SRC_URI="mirror://gnome/sources/procman/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE="nls"

RDEPEND="<gnome-extra/gal-1.99
	=gnome-base/libgtop-1.0*
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	append-flags $(gdk-pixbuf-config --cflags)
	econf \
		--disable-more-warnings \
		$(use_enable nls) \
		|| die "econf failed"
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README NEWS TODO
}
