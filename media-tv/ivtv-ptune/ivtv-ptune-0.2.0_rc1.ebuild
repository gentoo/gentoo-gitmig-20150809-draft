# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv-ptune/ivtv-ptune-0.2.0_rc1.ebuild,v 1.3 2004/10/26 20:30:39 iggy Exp $

DESCRIPTION="ivtv tuner perl scripts"
HOMEPAGE="http://ivtv.sourceforge.net"

# stupidly named tarballs
MY_Pt="${P/-ptune/}c"
MY_P="${MY_Pt/_/-}"

SRC_URI="http://67.18.1.101/~ckennedy/ivtv/${MY_P/1c/}/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-tv/ivtv
	dev-perl/Video-Frequencies
	dev-perl/Video-ivtv
	dev-perl/Getopt-Long
	dev-perl/Config-IniFiles
	X? ( dev-perl/perl-tk )"

src_compile() {
	echo
}

src_install() {
	cd ${WORKDIR}/${MY_P}/utils
	dobin ptune.pl ptune-ui.pl record-v4l2.pl
	newdoc README README.utils
	dodoc README.ptune
}
