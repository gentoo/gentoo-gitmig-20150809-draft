# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim-lcd/gpsim-lcd-0.2.1.ebuild,v 1.3 2005/03/25 20:48:00 blubb Exp $

inherit eutils

MY_PN="${PN/gpsim-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="2x20 LCD display module for GPSIM"
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html#modules http://www.dattalo.com/gnupic/lcd.html"
SRC_URI="http://www.dattalo.com/gnupic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-embedded/gpsim-0.21
	>=sys-devel/automake-1.8
	>=sys-devel/autoconf-2.59
	sys-apps/sed"

RDEPEND=">=dev-embedded/gpsim-0.21"


S=${WORKDIR}/${MY_P}

src_compile() {
	sed -i -e 's|  $srcdir/configure|  echo|' autogen.sh
	einfo "please ignore warning"
	env WANT_AUTOCONF=2.50 WANT_AUTOMAKE=1.8 ./autogen.sh || "autogen failed"
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	cp -ra ${S}/examples ${D}/usr/share/doc/${PF}
	chown root:root -R ${D}/usr/share/doc/${PF}
	find ${D}/usr/share/doc/${PF} -name 'Makefile*' -exec rm -f \{} \;
}
