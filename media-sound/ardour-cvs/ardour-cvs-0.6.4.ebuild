# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour-cvs/ardour-cvs-0.6.4.ebuild,v 1.5 2003/05/14 09:03:23 jje Exp $

IUSE="nls"

inherit cvs            

ECVS_SERVER="cvs.ardour.sourceforge.net:/cvsroot/ardour"
ECVS_MODULE="ardour"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/ardour" 
                                                                                
DESCRIPTION="multi-track hard disk recording software"
HOMEPAGE="http://ardour.sourceforge.net/"
SRC_URI="mirror://sourceforge/ardour/ardour-pixmaps-2.6.tar.bz2"

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
	>=media-libs/liblrdf-0.3.1"

RDEPEND="nls? ( sys-devel/gettext )"

S="${WORKDIR}/${PN/-cvs/}"

src_compile() {

	local myconf="--disable-dependency-tracking"
	export WANT_AUTOCONF_2_5=1
	sh autogen.sh
        # nasty little hack to create version.h, will remove when this
        # is fixed upstream...
        cd gtk_ardour 
        sh version.sh remake || die "failed to create version.h" 
        cd ..
	use nls || myconf="${myconf} --disable-nls"
        # diable ksi for now, not currently compiling...
        myconf="${myconf} --disable-ksi"
	econf ${myconf} || die "configure failed"

	# while troubleshooting upgrades to ardour-cvs-0.6 i changed from
	# emake to make.  Can probably change back.  Need to test.
	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

	pushd ${WORKDIR}
	mkdir pixmaps
	cd pixmaps
	unpack ${DISTFILES}/ardour-pixmaps-2.6.tar.bz2
	dodir /usr/share/ardour/pixmaps
	cp * ${D}/usr/share/ardour/pixmaps
	popd

	insinto /usr/share/ardour

        cp ardour.rc ardour.rc~
	sed -e 's/\/usr\/local\/music\/src\/ardour\//\/usr\/local\/share\/ardour\//' \
	    -e 's/\/home\/paul\//\/usr\/local\/share\/ardour\//' ardour.rc~ > ardour.rc
	cp ardour.rc sample_ardour.rc

	cp ardour_system.rc ardour_system.rc~
	sed -e 's/\/usr\/local\/music\/src\/ardour\//\/usr\/local\/share\/ardour\//' ardour_system.rc~ > ardour_system.rc

	doins ${S}/ardour_system.rc
	doins ${S}/ardour_ui.rc

	dodoc ${S}/AUTHORS ${S}/INSTALL ${S}/README ${S}/README.it \
		${S}/NEWS ${S}/COPYING ${S}/ChangeLog ${S}/sample_ardour.rc \
		${S}/FAQ
	doman ${S}/ardour.1 
}

pkg_postinst() {

	einfo ""
	einfo "ardour-cvs now depends on jack-cvs"
	einfo "make sure to re-emerge jack-cvs before re-emerging ardour-cvs"
	einfo "as the development of both programs are closely linked."
	einfo ""
	einfo "to get ardour to run you will need to copy the file sample_ardour.rc"
	einfo "from /usr/share/doc/${P}/sample_ardour.rc to your homedirectory"
	einfo "and set two environment variables."
	einfo "ARDOURRC should point to your where-ever you put your ardour.rc file"
	einfo "ARDOUR_SYSTEM_RC should point to /usr/share/ardour/ardour_system.rc"
	einfo ""

}
