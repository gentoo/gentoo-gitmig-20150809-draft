# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.99.4.ebuild,v 1.1 2002/08/05 15:33:59 aliz Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Powertweak"
SRC_URI="mirror://sourceforge/powertweak/${P}.tar.bz2"
HOMEPAGE="http://powertweak.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	>=dev-libs/libxml-1.8.10
	sys-devel/autoconf
	sys-devel/automake"

RDEPEND=">=sys-apps/pciutils-2.1.0
	gtk? ( =x11-libs/gtk+-1.2* )"

inherit libtool

src_unpack() {
	unpack ${A}

	cd ${S} ; patch -l -p1 < ${FILESDIR}/${P}-gentoo.diff

	for FILE in `find . -iname "Makefile*"`;do
		sed -e "s:\(^CFLAGS =.*\):\1 ${CFLAGS}:" \
			-e "s:\(^CPPFLAGS =.*\):\1 ${CPPFLAGS}:" \
			${FILE} > ${FILE}.hacked || die "Hack failed"
		mv ${FILE}.hacked ${FILE}
	done
}

src_compile() {
	elibtoolize

	use gtk || myconf="--disable-gtktest" 

	CFLAGS="${CPPFLAGS} -Wno-error"
	CPPFLAGS="${CPPFLAGS} -Wno-deprecated"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	docinto Documentation
	dodoc Documentation/* Documentation/Hackers/*

	use gtk || rm ${D}/usr/bin/gpowertweak
	
	exeinto /etc/init.d ; newexe ${FILESDIR}/powertweakd.rc6 powertweakd
}

pkg_postins() {
	einfo "This version adds powertweakd to be run at boot to apply changes to system"
}
