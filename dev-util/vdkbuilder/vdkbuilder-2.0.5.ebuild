# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/vdkbuilder/vdkbuilder-2.0.5.ebuild,v 1.3 2004/06/25 02:49:55 agriffis Exp $

IUSE="nls gnome"

MY_P=${PN}2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Visual Development Kit used for VDK Builder."
HOMEPAGE="http://vdkbuilder.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="dev-libs/vdk
	gnome? ( gnome-base/libgnome )"

src_compile() {

	local myconf

	use gnome \
		&& myconf="${myconf} --enable-gnome=yes" \
		|| myconf="${myconf} --enable-gnome=no"

	econf \
		`use_enable nls` \
		${myconf} || die "econf failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README TODO
}
