# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/roadnav/roadnav-0.18.ebuild,v 1.1 2007/10/08 06:23:58 dirtyepic Exp $

inherit wxwidgets

DESCRIPTION="Roadnav is a street map application with routing and GPS support"
HOMEPAGE="http://roadnav.sourceforge.net"
SRC_URI="mirror://sourceforge/roadnav/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gps festival flite openstreetmap scripting"

DEPEND="=x11-libs/wxGTK-2.6*
	~dev-libs/libroadnav-${PV}
	festival?	( app-accessibility/festival )
	flite?		( app-accessibility/flite )
	gps?		( sci-geosciences/gpsd )"

RDEPEND="${DEPEND}"

src_compile() {
	WX_GTK_VER=2.6
	need-wxwidgets gtk2

	econf \
	$(use_enable festival) \
	$(use_enable flite) \
	$(use_enable gps gpsd) \
	$(use_enable openstreetmap) \
	$(use_enable scripting) \
	--with-wx-config=${WX_CONFIG} \
	|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	# generic or empty
	for f in NEWS COPYING INSTALL; do
		rm -f "${D}"/usr/share/doc/${PN}/${f}
	done

	# --docdir is broken and hardcoded to ${PN}
	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${P}

	insinto /usr/share/applications
	doins "${S}"/roadnav.desktop
}

pkg_postinst() {
	echo
	elog "After upgrading to ${P} you will need to recompile your maps."
	echo
}
