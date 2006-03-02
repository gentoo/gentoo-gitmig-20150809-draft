# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ee/ee-0.3.12-r3.ebuild,v 1.5 2006/03/02 19:50:05 vanquirius Exp $

inherit gnuconfig eutils

DESCRIPTION="Electric Eyes image viewer"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

DEPEND="=sys-libs/db-1*
	>=gnome-base/gnome-libs-1.4.1.2-r1
	nls? ( sys-devel/gettext )"

RDEPEND="=sys-libs/db-1*
	>=gnome-base/gnome-libs-1.4.1.2-r1
	nls? ( virtual/libintl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-mo.diff
	strip-linguas -i po
}

src_compile() {
	econf \
		--program-suffix=yes \
		$(use_enable nls) \
		|| die "configure failure"
	emake || die "make failure"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failure"
	dodoc AUTHORS ChangeLog NEWS README

	# ee -> eeyes (bug #73179)
	# based on official Debian package's control file 
	mv "${D}"/usr/share/gnome/help/{ee,eeyes}

	sed 's:\(=ee\):\1yes:' "${D}"/usr/share/mime-info/ee.keys \
		> "${D}"/usr/share/mime-info/eeyes.keys
	rm "${D}"/usr/share/mime-info/ee.keys

	dodir /usr/share/applications
	sed 's:\(Exec=ee\):\1yes:' "${D}"/usr/share/gnome/apps/Graphics/ee.desktop \
		> "${D}"/usr/share/applications/eeyes.desktop
	rm -r "${D}"/usr/share/gnome/apps
}
