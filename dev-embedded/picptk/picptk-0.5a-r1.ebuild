# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/picptk/picptk-0.5a-r1.ebuild,v 1.1 2006/02/25 11:46:50 robbat2 Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="Picptk is a programmer supporting the whole PIC family including all memory types (EEPROM, EPROM, and OTP)"
HOMEPAGE="http://huizen.dds.nl/~gnupic/programmers_mike_butler.html"
# http://huizen.dds.nl/~gnupic/picptk-0.5a.tar.gz
SRC_URI="http://huizen.dds.nl/~gnupic/picptk-0.5a.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="=dev-tcltk/itk-3.3*
		 dev-tcltk/iwidgets
		dev-tcltk/itcl"
DEPEND="${RDEPEND}
	sys-devel/gcc
	sys-devel/automake
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-headerfix.patch
	epatch ${FILESDIR}/${PF}-gccfixes.patch
	cd ${S}
	export WANT_AUTOMAKE=1.4
	export WANT_AUTOCONF=2.1
	sed -i.orig -e '49,53d' \
		-e 's/AM_PROG_INSTALL/AC_PROG_INSTALL/g' \
		${S}/aclocal.m4 || die "sed failed"
	eautoconf || die "autoconf failed"
	eautomake || die "automake failed"
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
