# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/djvu/djvu-3.5.12.ebuild,v 1.5 2004/03/21 15:11:02 mholzer Exp $

inherit nsplugins

MY_P="${PN}libre-${PV}"

DESCRIPTION="A web-centric format and software platform for distributing documents and images."
HOMEPAGE="http://djvu.sourceforge.net"
SRC_URI="mirror://sourceforge/djvu/${MY_P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 sparc"
IUSE="xml qt"

DEPEND=">=media-libs/jpeg-6b-r2
	qt? ( >=x11-libs/qt-2.3 )"

S=${WORKDIR}/${MY_P}

src_compile() {

	# assembler problems and hence non-building with pentium4 
	# <obz@gentoo.org>
	replace-flags "-march=pentium4" "-march=pentium3"

	local myconf=""
	use xml \
		&& myconf="${myconf} --enable-xmltools"
	use qt \
		|| myconf="${myconf} --without-qt"

	econf ${myconf} || die
	make depend
	emake || die

}

src_install() {

	einstall || die
	# plugin installation from eclass
	inst_plugin /usr/lib/netscape/plugins/nsdejavu.so

}
