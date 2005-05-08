# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/plastique/plastique-0.3.ebuild,v 1.1 2005/05/08 00:40:46 cryos Exp $

inherit kde-functions

DESCRIPTION="The KDE plastik theme ported to QT3"
HOMEPAGE="http://static.int.pl/~mig21/dev/releases/plastique/"
SRC_URI="http://static.int.pl/~mig21/dev/releases/plastique/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mmx sse2"

DEPEND=""
RDEPEND=""

need-qt 3.3

src_compile() {
	local myconf
	# Have to use this syntax for enabling as configure is a little broken
	use mmx && myconf="--enable-mmx"
	use sse2 && myconf="${myconf} --enable-sse2"
	econf ${myconf} || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	dobin config/plastique-config
	insopts -m0755
	insinto ${QTDIR}/plugins/styles
	doins style/libplastique*
	dodoc AUTHORS ChangeLog README TODO
}
