# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnview/xnview-1.70-r2.ebuild,v 1.4 2007/01/28 19:52:36 nelchael Exp $

DESCRIPTION="XnView image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
SRC_URI="x86? ( http://download.xnview.com/XnView-x86-unknown-linux2.x-static-fc4.tgz )"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="x11-libs/libXau
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext
	x11-libs/libXp
	x11-libs/libXdmcp
	media-fonts/font-bh-lucidatypewriter-100dpi
	media-fonts/font-bh-lucidatypewriter-75dpi"
DEPEND=""

RESTRICT="strip"
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

	into /opt/XnView
	for x in xnview nview nconvert ; do
		dobin bin/${x}
		dosym /opt/XnView/bin/${x} /opt/bin/${x}
	done

	insinto /usr/share/X11/app-defaults
	newins app-defaults/XnView.ad XnView
	fperms 444 /usr/share/X11/app-defaults/XnView

	dodoc *.txt
	doman man/*.1

}
