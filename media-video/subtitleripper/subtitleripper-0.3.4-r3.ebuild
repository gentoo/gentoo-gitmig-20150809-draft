# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subtitleripper/subtitleripper-0.3.4-r3.ebuild,v 1.1 2008/04/11 15:48:50 yngwin Exp $

inherit versionator

MY_PV="$(replace_version_separator 2 "-")"

DESCRIPTION="DVD Subtitle Ripper for Linux"
HOMEPAGE="http://subtitleripper.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tgz"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/netpbm-10.41.0
		media-libs/libpng
		sys-libs/zlib"

RDEPEND="${DEPEND}
	>=app-text/gocr-0.39"

S="${WORKDIR}/${PN}"

src_compile() {
	# PPM library is libnetppm
	sed -i -e "s:ppm:netpbm:g" Makefile
	# fix for bug 210435
	sed -i -e "s:#include <ppm.h>:#include <netpbm/ppm.h>:g" spudec.c subtitle2pgm.c
	# we will install the gocrfilters into /usr/share/subtitleripper
	sed -i -e 's:~/sourceforge/subtitleripper/src/:/usr/share/subtitleripper:' pgm2txt

	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe pgm2txt srttool subtitle2pgm subtitle2vobsub vobsub2pgm

	insinto /usr/share/subtitleripper
	doins gocrfilter_*.sed

	dodoc ChangeLog README*
}
