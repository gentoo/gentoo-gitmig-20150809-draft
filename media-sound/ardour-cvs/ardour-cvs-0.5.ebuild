# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour-cvs/ardour-cvs-0.5.ebuild,v 1.2 2003/02/13 13:07:29 vapier Exp $

inherit cvs            

ECVS_SERVER="cvs.ardour.sourceforge.net:/cvsroot/ardour"
ECVS_MODULE="ardour"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/ardour" 
                                                                                
DESCRIPTION="multi-track hard disk recording software"
HOMEPAGE="http://ardour.sourceforge.net/"
SRC_URI="mirror://sourceforge/ardour/ardour-pixmaps-2.5.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="dev-util/pkgconfig
	>=media-libs/alsa-lib-0.9.0_rc2
	>=media-sound/jack-audio-connection-kit-0.34
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=media-libs/libsndfile-1.0.0
	sys-libs/gdbm
	media-libs/ladspa-sdk"

S="${WORKDIR}/${PN/-cvs/}"

src_compile() {

	sh autogen.sh

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

	cd ${WORKDIR}
	mkdir pixmaps
	cd pixmaps
	unpack ${DISTFILES}/ardour-pixmaps-2.5.0.tar.gz
	dodir /usr/share/ardour/pixmaps
	cp * ${D}/usr/share/ardour/pixmaps

	insinto /etc/skel
	newins ${FILESDIR}/asoundrc .asoundrc

	insinto /etc
	doins ${S}/ardour.rc

}
