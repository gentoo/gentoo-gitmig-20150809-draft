# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/XWine/XWine-0.3.2.ebuild,v 1.3 2004/02/20 06:08:32 mr_bones_ Exp $

DESCRIPTION="GTK+ frontend for Wine"
HOMEPAGE="http://darken.tuxfamily.org/pages/xwine_en.html"
SRC_URI="http://darken.tuxfamily.org/projets/${P}_en.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1*
	sys-devel/bison
	>=gnome-base/gnome-libs-1.4.2
	>=gnome-base/ORBit-0.5.17
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P}_en

src_compile() {
	econf `use_enable nls` || die
	epatch ${FILESDIR}/fix-compile.patch
	emake || die
}

src_install() {
	addwrite /usr/share/
	einstall || die
	# Don't need to install docs twice
	rm -rf ${D}/usr/share/doc/xwine
	dodoc doc/Manual* FAQ* BUGS COPYING AUTHORS NEWS README TODO
}

pkg_postinst() {
	einfo "${PN} requires a setup Wine to start....It is recommended"
	einfo "that you run winesetuptk prior to running ${PN} to setup"
	einfo "a base Wine install"
	einfo ""
	einfo "You should also emerge wine or nwwine at this point"
}
