# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/realbasic/realbasic-2007.3.ebuild,v 1.3 2008/12/26 03:00:41 wormo Exp $

inherit eutils portability

DESCRIPTION="VB6 for Linux!"
HOMEPAGE="http://www.realsoftware.com/products/realbasic/"
SRC_URI="http://realsoftware.cachefly.net/REALbasic2007r3/REALbasicLinux.tgz"

LICENSE="REALbasic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="x86? ( =virtual/libstdc++-3*
		        =x11-libs/gtk+-2*
		        =dev-libs/glib-2*
		        net-print/cups
		        x11-libs/libXi
		        x11-libs/libXext
		        x11-libs/libX11
		        x11-libs/libXau
		        x11-libs/libXdmcp
	            x11-libs/pango
		      )
		 amd64? ( app-emulation/emul-linux-x86-baselibs
		          app-emulation/emul-linux-x86-compat
		          app-emulation/emul-linux-x86-gtklibs
		          app-emulation/emul-linux-x86-xlibs
		        )"

S=${WORKDIR}/REALbasic2007Release3

src_install() {
	dodir /opt/bin
	treecopy . "${D}"/opt/REALbasic || die
	dosym /opt/REALbasic/REALbasic2007 /opt/bin/REALbasic
	newicon RBCube.xpm REALbasic.xpm || die
	make_desktop_entry REALbasic REALbasic REALbasic
}
