# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.7.2.ebuild,v 1.6 2005/03/30 16:46:50 hansmi Exp $

DESCRIPTION="Enlightenment Window Manager"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/enlightenment-${PV/_/-}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="doc esd nls nothemes xrandr"

RDEPEND="esd? ( >=media-sound/esound-0.2.19 )
	=media-libs/freetype-2*
	media-libs/imlib2
	virtual/x11"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"
PDEPEND="!nothemes? ( x11-themes/ethemes )
	doc? ( app-doc/edox-data )"

S=${WORKDIR}/${PN}-${PV/_pre?}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable esd sound) \
		$(use_enable xrandr) \
		--enable-hints-ewmh \
		--enable-fsstd \
		--enable-zoom \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/enlightenment
	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README
}
