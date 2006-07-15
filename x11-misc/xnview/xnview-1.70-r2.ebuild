# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnview/xnview-1.70-r2.ebuild,v 1.2 2006/07/15 11:04:41 nelchael Exp $

DESCRIPTION="XnView image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
SRC_URI="x86? ( http://download.xnview.com/XnView-x86-unknown-linux2.x-static-fc4.tgz )"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libXau
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXp
		x11-libs/libXdmcp
		|| ( media-fonts/font-bh-lucidatypewriter-100dpi media-fonts/font-bh-lucidatypewriter-75dpi ) )
	virtual/x11 )"
DEPEND="${RDEPEND}
		sys-libs/glibc"

S="${WORKDIR}/XnView-1.70-x86-unknown-linux2.x-static-fc4"

src_unpack() {

	unpack "${A}"

	einfo "Fixing RPATH"
	cd "${S}"
	sed -i -e 's#.:/usr/local/lib#/opt/XnView/lib\x00#g' bin/xnview
	sed -i -e 's#.:/usr/local/lib#/opt/XnView/lib\x00#g' bin/nview
	sed -i -e 's#.:/usr/local/lib#/opt/XnView/lib\x00#g' bin/nconvert

}

src_install() {

	BASE_DIR=/opt/XnView

	into /opt
	dobin bin/{xnview,nview,nconvert}

	cp app-defaults/XnView.ad app-defaults/XnView
	insinto /usr/lib/X11/app-defaults/XnView
	doins app-defaults/XnView
	fperms 444 /usr/lib/X11/app-defaults/XnView

	doman man/*.1

	dodoc *.txt

}
