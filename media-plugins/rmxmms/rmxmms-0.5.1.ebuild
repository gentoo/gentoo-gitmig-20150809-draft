# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/rmxmms/rmxmms-0.5.1.ebuild,v 1.6 2003/07/04 07:49:34 jje Exp $

IUSE=""

inherit gcc

S=${WORKDIR}/rmxmms/${P}
DESCRIPTION="RealAudio plugin for xmms"
SRC_URI="ftp://ftp.xmms.org/xmms/plugins/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.xmms.org http://forms.real.com/rnforms/resources/server/realsystemsdk/index.html#download"
REALSDK="rsg2sdk_r4.tar.gz"
REALSDK_HOMEPAGE="http://proforma.real.com/rnforms/resources/server/realsystemsdk/index.html"

SLOT="0"
LICENSE="GPL-2 realsdk"
KEYWORDS="x86 -ppc -sparc "

DEPEND="media-sound/xmms
	media-video/realplayer"

pkg_setup() {
	if [ "`gcc-major-version`" -eq "3" ]; then
    	eerror "This plugin will not work when compiled with gcc-3.x"
		eerror "Either install and select a gcc-2.95.x compiler with"
		eerror  "gcc-config, or give up."
		die "Doesn't work with gcc-3.xx"
    fi
}

src_unpack () {

	# Check if we got the SDK from real.com
	if [ ! -f ${DISTDIR}/${REALSDK} ]; then
		einfo "Please download the Real System SDK file from www.real.com"
		einfo "and place it in ${DISTDIR}."
		einfo "The file should be named ${REALSDK} and a good starting point is:"
		einfo "${REALSDK_HOMEPAGE}"
		einfo "The SDK is needed only to build the plugin, it won't be installed."
		rm -rf ${WORKDIR}
		exit 1
	fi

	# Unpack both realsdk and rmxmms
	mkdir ${WORKDIR}/realsdk
	mkdir ${WORKDIR}/rmxmms

	cd ${WORKDIR}/realsdk
	unpack ${REALSDK}

	cd ${WORKDIR}/rmxmms
	unpack ${A}

}

src_compile () {
	# patch Makefiles to use -lgcc
    cd ${S}/rmxmms
    sed -e 's/^LIBS =/LIBS = -lgcc/' Makefile.in > Makefile.in.new
    sed -e 's/^LDFLAGS =/LDFLAGS = -lgcc/' Makefile.in.new > Makefile.in
    
	cd ${S}
	econf "--with-realsdk-dir=${WORKDIR}/realsdk/rmasdk_6_0" || die
	emake || die
}

src_install () {
	
	make install DESTDIR=${D} || die

	dodoc ${S}/README
	dodoc ${S}/COPYING
	dodoc ${S}/INSTALL
	dodoc ${S}/ChangeLog

}

