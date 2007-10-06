# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libmilter/libmilter-8.13.7.ebuild,v 1.3 2007/10/06 12:32:44 dragonheart Exp $

inherit eutils

MY_PN="sendmail"

DESCRIPTION="The Sendmail Filter API (Milter)"
HOMEPAGE="http://www.sendmail.org/"
SRC_URI="ftp://ftp.sendmail.org/pub/sendmail/sendmail.${PV}.tar.gz"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

MY_SRC=sendmail
S="${WORKDIR}/${MY_SRC}-${PV}"

src_compile() {
	pushd libmilter
	sh Build || die "libmilter compilation failed"
	popd
}

src_install () {
	OBJDIR="obj.`uname -s`.`uname -r`.`arch`"
	dodir /usr/$(get_libdir)

	dodir /usr/include/libmilter
	make DESTDIR=${D} MANROOT=/usr/share/man/man \
			SBINOWN=root SBINGRP=root UBINOWN=root UBINGRP=root \
			MANOWN=root MANGRP=root INCOWN=root INCGRP=root \
			LIBOWN=root LIBGRP=root GBINOWN=root GBINGRP=root \
			MSPQOWN=root CFOWN=root CFGRP=root \
			LIBDIR=/usr/$(get_libdir) \
			install -C ${OBJDIR}/libmilter \
			|| die "install failed"

	newdoc libmilter/README README.libmilter

}
