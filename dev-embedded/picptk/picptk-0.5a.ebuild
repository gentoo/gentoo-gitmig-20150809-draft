# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/picptk/picptk-0.5a.ebuild,v 1.5 2004/07/19 02:48:55 robbat2 Exp $

#this is for autoconf
inherit kde-functions eutils

DESCRIPTION="Picptk is a programmer supporting the whole PIC family including all memory types (EEPROM, EPROM, and OTP)"
HOMEPAGE="http://huizen.dds.nl/~gnupic/programmers_mike_butler.html"
# http://huizen.dds.nl/~gnupic/picptk-0.5a.tar.gz
SRC_URI="http://huizen.dds.nl/~gnupic/picptk-0.5a.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-tcltk/itcl"
DEPEND="${RDEPEND}
	sys-devel/gcc
	sys-devel/automake
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-headerfix.patch
	cd ${S}
	need-autoconf 2.1
	automake
	autoconf
}

src_install() {
	#dobin picprog
	#dodoc README #jdm*.png adapter.jpg
	#dohtml picprog.html *.jpg *.png
	#doman picprog.1
	einstall || die "einstall failed"
	dodoc AUTHORS NEWS README TODO
	newdoc .picprc sample.picprc
}
