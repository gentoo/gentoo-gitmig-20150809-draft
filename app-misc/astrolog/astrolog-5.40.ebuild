# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/astrolog/astrolog-5.40.ebuild,v 1.6 2004/12/08 21:41:42 sekretarz Exp $

DESCRIPTION="A many featured astrology chart calculation program"
HOMEPAGE="http://www.astrolog.org/astrolog.htm"
SRC_URI="http://www.astrolog.org/ftp/ast54unx.shr"
LICENSE="astrolog"
SLOT="0"

# works fine on x86 - runs probably on other architectures, too
KEYWORDS="x86 ppc64 ppc ~amd64"

IUSE="X"

S="${WORKDIR}"

src_unpack() {
	bash ${DISTDIR}/ast54unx.shr
	# if we use X, we need to add -L/usr/X11R6/lib to compile succesful
	use X && sed -i -e "s:-lm -lX11:-lm -lX11 -L/usr/X11R6/lib:g" Makefile

	# if we do NOT use X, we disable it by removing the -lX11 from the Makefile
	# and remove the "#define X11" and "#define MOUSE" from astrolog.h
	use X || ( sed -i -e "s:-lm -lX11:-lm:g" Makefile
		   sed -i -e "s:#define X11:/*#define X11:g" astrolog.h
		   sed -i -e "s:#define MOUSE:/*#define MOUSE:g" astrolog.h )

	# we use /usr/share/astrolog for config and (optional) ephemeris-data-files
	sed -i -e "s:~/astrolog:/usr/share/astrolog:g" astrolog.h

	# any user may have an own astrolog configfile
	sed -i -e "s:astrolog.dat:astrolog.dat:g" astrolog.h

	# include users CFLAGS
	sed -i -e "s:= -O:= ${CFLAGS}":g Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	cp astrolog ${D}/usr/bin/
	dodoc Helpfile.540 README.1ST README.540 Update.540
	dodir /usr/share/astrolog
	cp astrolog.dat ${D}/usr/share/astrolog/
}

pkg_postinst() {
	ewarn "There is a sample config file /usr/share/astrolog/astrolog.dat"
	ewarn "astrolog looks in current dir for a file astrolog.dat before"
	ewarn "using the file in /usr/share/astrolog"
	ewarn "If you want extended accuracy of astrolog's calculations you"
	ewarn "can emerge the optional package \"astrolog-ephemeris\" which"
	ewarn "needs ~4.7 MB additional diskspace for the ephemeris-files"
}
