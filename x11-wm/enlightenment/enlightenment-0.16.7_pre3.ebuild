# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.7_pre3.ebuild,v 1.1 2004/05/31 06:20:08 vapier Exp $

EVER="${PV/_pre*}"
MY_PV="${EVER}-0.65"
DESCRIPTION="Enlightenment Window Manager"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/enlightenment-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE="nls esd doc xrandr nothemes"

DEPEND="esd? ( >=media-sound/esound-0.2.19 )
	=media-libs/freetype-2*
	media-libs/imlib2
	virtual/x11"
RDEPEND="nls? ( sys-devel/gettext )"
PDEPEND="!nothemes? ( x11-themes/ethemes )
	doc? ( app-doc/edox-data )"

S=${WORKDIR}/${PN}-${EVER}

src_compile() {
	econf \
		`use_enable nls` \
		`use_enable esd sound` \
		`use_enable xrandr` \
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
