# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion-devel/ion-devel-20030327.ebuild,v 1.3 2003/09/06 04:16:43 msterret Exp $

ION_VERSION="${PV}"
inherit ion

DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.students.tut.fi/~tuomov/ion/"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="${DEPEND}
	app-misc/run-mailcap"

src_compile() {
	src_configure

	sed -e "s:PREFIX/etc/ion:/etc/X11/${PN}:" \
		-e "s:PREFIX/doc/ion:/usr/share/doc/${P}:" \
		-e 's:~/.ion/:~/.ion-devel/:' \
		man/ion.1x.in > man/ion.1x

	sed -e 's:PREFIX/etc:/etc/X11:' \
		-e 's:PREFIX/lib:/usr/lib:' \
		-e 's:PREFIX/bin:/usr/bin:' \
		scripts/ion.in > scripts/ion

	make depend || die
	emake || die

}

src_install() {
	make PREFIX=${D}/usr ETCDIR=${D}/etc/X11 install || die
	echo -n "#!/bin/sh\n/usr/bin/ion" > ion-devel
	exeinto /etc/X11/Sessions
	doexe ion-devel
}
