# Copyright 2002, Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/media-sound/rmxmms/rmxmms-0.5.1.ebuild,v 1.2 2002/07/21 13:50:33 seemant Exp $

S=${WORKDIR}/rmxmms/${P}
DESCRIPTION="RealAudio plugin for xmms"
SRC_URI="ftp://ftp.xmms.org/xmms/plugins/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.xmms.org http://forms.real.com/rnforms/resources/server/realsystemsdk/index.html#download""
REALSDK="rsg2sdk_r4.tar.gz"

SLOT="0"
LICENSE="GPL-2 realsdk"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND="media-sound/xmms
	media-video/realplayer"

src_unpack () {

	# Check if we got the SDK from real.com
	if [ ! -f ${DISTDIR}/${REALSDK} ]; then
		einfo "Please download the Real System SDK file from www.real.com"
		einfo "and place it in ${DISTDIR}."
		einfo "The file should be named ${REALSDK} and a good starting point"
		einfo "is ${REALSDK_HOMEPAGE}."
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

