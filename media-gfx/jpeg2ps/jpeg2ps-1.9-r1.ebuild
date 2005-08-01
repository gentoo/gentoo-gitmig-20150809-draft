# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpeg2ps/jpeg2ps-1.9-r1.ebuild,v 1.1 2005/08/01 01:30:14 pclouds Exp $

DESCRIPTION="Converts JPEG images to Postscript using a wrapper"
HOMEPAGE="http://www.pdflib.com/products/more/jpeg2ps.html"
SRC_URI="http://www.pdflib.com/products/more/jpeg2ps/${P}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-apps/sed"
RDEPEND=""

src_compile() {
	local pagesize=""
	if [ -h /etc/localtime ]; then
		local continent=$(readlink /etc/localtime | cut -d / -f 5)
		[ "${continent}" = "Europe" ] && pagesize="-DA4"
	fi
	emake CFLAGS="-c ${CFLAGS} ${pagesize}" || die "emake failed"
}

src_install() {
	# The Makefile is hard-coded to install to /usr/local/ so we
	# simply copy the files manually
	dobin jpeg2ps || die "dobin failed"
	doman jpeg2ps.1 || die "doman failed"
	dodoc jpeg2ps.txt || die "dodoc failed"
}

pkg_postinst() {
	einfo
	if [ -z ${pagesize} ]; then
		einfo "By default, this installation of jpeg2ps will generate"
		einfo "letter size output.  You can force A4 output with"
		einfo "    jpeg2ps -p a4 file.jpg > file.ps"
	else
		einfo "By default, this installation of jpeg2ps will generate"
		einfo "A4 size output.  You can force letter output with"
		einfo "    jpeg2ps -p letter file.jpg > file.ps"
	fi
	einfo
}
