# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour-cvs/ardour-cvs-0.6.ebuild,v 1.5 2003/04/12 04:49:25 jje Exp $

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

DEPEND="$DEPEND
        dev-util/pkgconfig
	>=media-libs/alsa-lib-0.9.0_rc7
	media-sound/jack-cvs
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=media-libs/libsndfile-1.0.4
	sys-libs/gdbm
	>=media-libs/ladspa-sdk-1.12
	>=media-libs/libsamplerate-0.0.14
	>=media-libs/liblrdf-0.2.4"

S="${WORKDIR}/${PN/-cvs/}"

src_compile() {

	sh autogen.sh
        # nasty little hack to create version.h, will remove when this
        # is fixed upstream...
        cd gtk_ardour 
        sh version.sh remake || die "failed to create version.h" 
        cd ..
	econf || die "configure failed"

	# while troubleshooting upgrades to ardour-cvs-0.6 i changed from
	# emake to make.  Can probably change back.  Need to test.
	make || die "parallel make failed"

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
	einfo "as the development of both programs are closely linked."
	einfo ""

}
