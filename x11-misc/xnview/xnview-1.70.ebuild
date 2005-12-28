# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnview/xnview-1.70.ebuild,v 1.1 2005/12/28 19:32:36 nelchael Exp $

DESCRIPTION="XnView image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
SRC_URI="x86? ( http://download.xnview.com/XnView-x86-unknown-linux2.x-static-fc4.tgz )"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~x86 -*"
IUSE=""

DEPEND="virtual/x11"

S="${WORKDIR}/XnView-1.70-x86-unknown-linux2.x-static-fc4"

src_install() {
	BASE_DIR=/opt/XnView

	into /opt
	dobin bin/{xnview,nview,nconvert}

	insinto /etc/env.d
	doins ${FILESDIR}/99XnView

	cp app-defaults/XnView.ad app-defaults/XnView
	insinto /usr/lib/X11/app-defaults/XnView
	doins app-defaults/XnView
	fperms 444 /usr/lib/X11/app-defaults/XnView

	doman man/*.1

	dodoc *.txt
}
