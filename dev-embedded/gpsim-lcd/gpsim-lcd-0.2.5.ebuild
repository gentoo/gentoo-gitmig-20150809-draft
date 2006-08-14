# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim-lcd/gpsim-lcd-0.2.5.ebuild,v 1.2 2006/08/14 10:06:48 dragonheart Exp $

inherit eutils

MY_PN="${PN/gpsim-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="2x20 LCD display module for GPSIM"
HOMEPAGE="http://www.dattalo.com/gnupic/lcd.html"
SRC_URI="mirror://sourceforge/gpsim/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-embedded/gpsim-0.21.2
	>=sys-devel/automake-1.8
	>=sys-devel/autoconf-2.59"

RDEPEND=">=dev-embedded/gpsim-0.21.2"

S=${WORKDIR}/${MY_P}

src_compile() {
	sed -i -e 's|  $srcdir/configure|  echo|' autogen.sh
	einfo "please ignore warning"
	env WANT_AUTOCONF=2.5 WANT_AUTOMAKE=1.8 ./autogen.sh || "autogen failed"
	econf --disable-dependency-tracking || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	cp -pPR ${S}/examples ${D}/usr/share/doc/${PF}
	find ${D}/usr/share/doc/${PF} -name 'Makefile*' -exec rm -f \{} \;
	chmod -R 644 ${D}/usr/share/doc/${PF}
	chmod 755 ${D}/usr/share/doc/${PF}/examples
}
