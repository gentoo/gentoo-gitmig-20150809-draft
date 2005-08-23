# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/polymer/polymer-0.3.1.ebuild,v 1.3 2005/08/23 15:26:34 greg_g Exp $

inherit qt3

DESCRIPTION="The KDE plastik theme ported to Qt"
HOMEPAGE="http://static.int.pl/~mig21/dev/releases/polymer/"
SRC_URI="http://static.int.pl/~mig21/dev/releases/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="mmx sse2"

DEPEND="$(qt_min_version 3.3)"

src_compile() {
	local myconf
	# Have to use this syntax for enabling as configure is a little broken
	use mmx && myconf="--enable-mmx"
	use sse2 && myconf="${myconf} --enable-sse2"
	econf ${myconf} || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	dobin config/polymer-config
	insopts -m0755
	insinto ${QTDIR}/plugins/styles
	doins style/libpolymer*
	dodoc AUTHORS ChangeLog README TODO
}
