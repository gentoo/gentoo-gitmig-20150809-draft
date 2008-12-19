# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiocompress/audiocompress-2.0.ebuild,v 1.1 2008/12/19 15:15:33 aballier Exp $

inherit toolchain-funcs flag-o-matic

MY_P="AudioCompress-${PV}"
DESCRIPTION="Very gentle 1-band dynamic range compressor"
HOMEPAGE="http://beesbuzz.biz/code/"
SRC_URI="http://beesbuzz.biz/code/audiocompress/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
#-sparc: 1.5.5 - Gdk-ERROR **: BadValue (integer parameter out of range for operation) serial 7 error_code 2 request_code 1 minor_code 0
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="esd"

DEPEND="esd? ( media-sound/esound )"

S=${WORKDIR}/${MY_P}

src_compile() {
	echo "AudioCompress: AudioCompress.o compress.o" > Makefile
	use esd && append-flags "-DUSE_ESD `esd-config --cflags`"
	tc-export CC
	emake LDLIBS="$(use esd && echo `esd-config --libs`)" || die
}

src_install() {
	dobin AudioCompress || die
	dodoc ChangeLog README TODO
}
