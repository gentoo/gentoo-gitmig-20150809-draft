# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/mbrola/mbrola-3.0.1h-r1.ebuild,v 1.19 2006/04/28 19:30:11 josejx Exp $

IUSE=""

S=${WORKDIR}

DESCRIPTION="us1, us2, and us3 mbrola voice libraries for Festival TTS"
HOMEPAGE="http://tcts.fpms.ac.be/synthesis/mbrola.html"

SRC_URI_BASE="http://tcts.fpms.ac.be/synthesis/mbrola"
SRC_URI="${SRC_URI_BASE}/bin/pclinux/mbr301h.zip
	 ${SRC_URI_BASE}/dba/us1/us1-980512.zip
	 ${SRC_URI_BASE}/dba/us2/us2-980812.zip
	 ${SRC_URI_BASE}/dba/us3/us3-990208.zip"

RDEPEND=">=app-accessibility/festival-1.4.2"

DEPEND="${RDEPEND}
	app-arch/unzip"

RDEPEND="${RDEPEND}"

SLOT="0"
LICENSE="MBROLA"
KEYWORDS="amd64 -ppc ppc64 sparc x86"

src_compile() {
	case ${ARCH} in
	x86|amd64)
		cp mbrola-linux-i386 mbrola || die
	;;
	ppc)
		cp mbrola206a-linux-ppc mbrola || die
	;;
	sparc)
		cp mbrola-SuSElinux-ultra1.dat mbrola || die
	;;
	alpha)
		cp mbrola-linux-alpha mbrola || die
	;;
	*)
		einfo "mbrola binary not available on this architecture.  Still installing voices."
	esac
}

src_install () {
	# Take care of main binary
	[ -f mbrola ] && dobin mbrola
	dodoc readme.txt

	# Now install the vioces
	FESTLIB=/usr/lib/festival/voices/english
	insinto ${FESTLIB}/us1_mbrola/us1
	doins us1/us1 us1/us1mrpa
	insinto ${FESTLIB}/us1_mbrola/us1/TEST
	doins us1/TEST/*
	dodoc us1/us1.txt

	insinto ${FESTLIB}/us2_mbrola/us2
	doins us2/us2
	insinto ${FESTLIB}/us2_mbrola/us2/TEST
	doins us2/TEST/*
	dodoc us2/us2.txt

	insinto ${FESTLIB}/us3_mbrola/us3
	doins us3/us3
	insinto ${FESTLIB}/us3_mbrola/us3/TEST
	doins us3/TEST/*
	dodoc us3/us3.txt
}
