# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour-cvs/ardour-cvs-0.5-r1.ebuild,v 1.1 2003/01/02 10:50:02 raker Exp $

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


DEPEND="dev-util/pkgconfig
	>=media-libs/alsa-lib-0.9.0_rc6
	>=media-sound/jack-cvs-0.44
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

pkg_postinst() {

	einfo ""
	einfo "ardour-cvs now depends on jack-cvs"
	einfo "make sure to re-emerge jack-cvs before re-emerging ardour-cvs"
	einfo ""

}
