# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-analogtv/vdr-analogtv-0.9.37.ebuild,v 1.2 2006/04/17 16:36:21 zzam Exp $

inherit vdr-plugin

#S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://akool.bei.t-online.de/"
SRC_URI="http://www.akool.homepage.t-online.de/analogtv/download/vdr-${VDRPLUGIN}-${PV}.tar.bz2
		http://www.akool.homepage.t-online.de/analogtv/download/rte-09sep04.tar.bz2
		mirror://vdrfiles/${PN}/rte-09sep04-mp1e-gentoo.patch"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6
	media-libs/libdvb"

src_unpack()
{
	vdr-plugin_src_unpack

	cd ${S}
	ln -s ../rte-09sep04 rte

	sed -i -e "s:^INCLUDES += :INCLUDES += -I/usr/include/libdvb :" Makefile

	epatch ${DISTDIR}/rte-09sep04-mp1e-gentoo.patch

	epatch ${FILESDIR}/${P}-gcc-3.4.diff
	epatch ${FILESDIR}/${P}-asm-fpic.diff
	epatch ${FILESDIR}/${P}-kpes_to_ts.patch
	epatch ${FILESDIR}/${P}-includes.diff
}

src_compile()
{
	cd rte/mp1e
	libtoolize --copy --force

	econf || die "econf failed"
	emake || die "emake failed"

	cd ${S}
	vdr-plugin_src_compile
}

src_install()
{
	vdr-plugin_src_install

	cd ${S}/rte/mp1e
	doman mp1e.1
	docinto mp1e
	dodoc BUGS ChangeLog
	insinto /usr/bin
	dobin mp1e
}
