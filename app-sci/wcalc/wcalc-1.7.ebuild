# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/wcalc/wcalc-1.7.ebuild,v 1.4 2004/12/07 04:48:36 gongloo Exp $

DESCRIPTION="A flexible command-line scientific calculator"
HOMEPAGE="http://w-calc.sourceforge.net"
SRC_URI="mirror://sourceforge//w-calc/Wcalc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc-macos"
# The argument "--without-readline" is accepted by the configure script but
# breaks the build, so the readline USE flag cannot be used.
IUSE=""

DEPEND=">=sys-libs/readline-4.3-r4"

S=${WORKDIR}/Wcalc-${PV}

src_compile() {
	econf || die "Configuration failed."
	emake || die "Compilation failed."
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING COPYRIGHT NEWS
	insinto /usr/share/doc/${PF}
	doins ReadMe.rtf

	# Wcalc icons
	insinto /usr/share/pixmaps
	newins w.png wcalc.png
	newins Wred.png wcalc-red.png
}
