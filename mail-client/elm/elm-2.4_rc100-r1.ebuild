# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/elm/elm-2.4_rc100-r1.ebuild,v 1.2 2004/09/22 10:10:14 ticho Exp $

DESCRIPTION="a classic mail client enhanced by Michael Elkins"
HOMEPAGE="http://www.ozone.fmi.fi/KEH/"
SRC_URI="http://www.ozone.fmi.fi/KEH/elm-2.4ME+100.tar.gz"

LICENSE="Elm"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha"

IUSE="spell"

DEPEND="virtual/libc
	>=net-mail/mailbase-0.00-r5
	dev-libs/openssl
	spell? ( app-text/ispell )"

S=${WORKDIR}/elm2.4.ME+.100

src_compile() {

	sed -i -e "s:\$shlib:${D}\$shlib:g" \
		lib/Makefile.SH

	sed -i -e "s:\$shlib:${D}\$shlib:g" \
		shared_libs/iconv/Makefile.SH

	sed -i -e "s:\$shlib:${D}\$shlib:g" \
		shared_libs/smtp/Makefile.SH

	sed -i -e "s:\$shlib:${D}\$shlib:g" \
		shared_libs/tls/Makefile.SH

	sed -i -e "s:elmunidata -I :elmunidata -w ${D}usr/lib/elm.map.bin/unidata.bin :" \
	    -e "s:\$lib$:${D}\$lib:" \
		src/Makefile.SH

	sed -i -e "s:\$lib$:${D}\$lib:" \
		utils/Makefile.SH

	sed -i -e "s:\"\$lib\":\"${D}\$lib\":" \
	    -e "s:\$lib$:${D}\$lib:" \
		doc/Makefile.SH

	sed -e "s:helphome\t\"\$lib:helphome\t\"${D}\$lib:" \
	    -e "s:\"\$lib/elmrc-info:\"${D}\$lib/elmrc-info:" \
	    -e "s:\$shlib:${D}\$shlib:" \
		hdrs/sysdefs.SH

	sed -i -e "s:install_prefix/man:install_prefix/share/man:" \
		-e "s:etc=\"\$lib\":etc=\"/etc/elm\":" \
		-e "s:dflt=\"-O\":dflt=\"${CFLAGS}\":" \
		-e "s:dflt=cc:dflt=gcc:" \
		Configure

	local myconf
	use spell && myconf="ispell=\'y\'"

	./Configure -P/usr -b ${myconf} || die "configure failed"

	make || die "make failed"

}

src_install() {

	dodir /usr/lib/elm.map.txt /usr/lib/elm.map.bin /etc/elm /usr/bin \
		/usr/share/man/man1 /usr/share/man/cat1

	cd ${S}/src
	cp Makefile Makefile.orig
	sed \
		-e "s:-G -I -C:-G -w \${D}etc/elm/elm.rc -C:" \
		< Makefile.orig > Makefile

	cd ${S}
	make \
		DEST=${D}usr/bin \
		MAN=${D}usr/share/man/man1 \
		CATMAN=${D}usr/share/man/cat1 \
		ETC=${D}etc/elm install || die "make install failed"

	insinto /usr/lib/elm.map.txt
	doins charset/MAPPINGS/ISO8859/*
}
