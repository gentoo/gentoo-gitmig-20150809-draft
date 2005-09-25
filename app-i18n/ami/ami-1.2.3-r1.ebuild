# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ami/ami-1.2.3-r1.ebuild,v 1.1 2005/09/25 00:47:34 matsuu Exp $

inherit eutils

IUSE=""

DESCRIPTION="Korean IMS Ami"
SRC_URI="http://download.kldp.net/ami/${P}.tar.gz
	http://ami.kldp.net/hanja.dic.gz"
HOMEPAGE="http://ami.kldp.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.7.0"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-imhangul_status.patch
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /usr/share/ami
	doins ${WORKDIR}/hanja.dic || die

	insinto /usr/share/applnk/Utilities; doins ami.kdelnk
	insinto /etc/CORBA/servers; doins ami.gnorba

	#dosym ami /usr/bin/ami_applet
	#insinto /usr/share/applets/Utility; doins ami.desktop

	dodoc AUTHORS COPYING* ChangeLog INSTALL README README.en NEWS THANKS
}
