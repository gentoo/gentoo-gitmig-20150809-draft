# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/picptk/picptk-0.5a.ebuild,v 1.2 2004/03/15 23:25:14 dragonheart Exp $

#this is for autoconf
inherit kde-functions eutils

DESCRIPTION="Picptk is a programmer supporting the whole PIC family including all memory types (EEPROM, EPROM, and OTP)"
HOMEPAGE="http://huizen.dds.nl/~gnupic/programmers_mike_butler.html"
# http://huizen.dds.nl/~gnupic/picptk-0.5a.tar.gz
SRC_URI="http://huizen.dds.nl/~gnupic/picptk-0.5a.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
RDEPEND="dev-tcltk/itcl"
DEPEND="${RDEPEND} sys-devel/gcc sys-devel/automake sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-headerfix.patch
	cd ${S}
	need-autoconf 2.1
	automake
	autoconf
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
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
