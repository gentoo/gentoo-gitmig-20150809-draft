# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-2.0_rc1.ebuild,v 1.4 2004/01/26 00:33:21 vapier Exp $

inherit eutils libtool

HOMEPAGE="http://faac.sourceforge.net/"
SRC_URI="mirror://sourceforge/faac/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
DESCRIPTION="FAAD2 is the fastest ISO AAC audio decoder available. FAAD2 correctly decodes all MPEG-4 and MPEG-2 MAIN, LOW, LTP, LD and ER object type AAC files."
S="${WORKDIR}"
IUSE="xmms"
KEYWORDS="~x86 ~ppc ~sparc amd64"
DEPEND=">=media-libs/libsndfile-1.0.1
	>=libtool-1.4.1-r10
	sys-devel/automake
	sys-devel/autoconf
	xmms? ( >=media-sound/xmms-1.2.7
			media-libs/id3lib )"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	sh ./bootstrap
	elibtoolize
	if [ ! "`use xmms`" ]
	then
		rm -rf ${S}/plugins/xmms/*
	fi
	econf
	if [ "`use xmms`" ]
	then
		cd ${S}/plugins/xmms
		elibtoolize
		econf
		sed -e "s:CFLAGS =:CFLAGS = -I ../../../include:" \
		-e "s:libdir = \`xmms-config --input-plugin-dir\`:libdir = ${D}/\`xmms-config --input-plugin-dir\`:" \
		${S}/plugins/xmms/src/Makefile > Makefile.new
		mv Makefile.new ${S}/plugins/xmms/src/Makefile
	else
		sed -e "s:plugins::g" Makefile > Makefile.new
		mv Makefile.new Makefile
	fi
	cd ${S}/frontend
	cp Makefile Makefile.orig
	sed -e "s:CCLD = \$(CC):CCLD = \$(CXX):" Makefile.orig > Makefile
	cd ${S}

	emake || die
}

src_install() {
	cd ${S}/plugins/xmms/src/
	sed -e "s:@inst_prefix_dir@:-L${D}/usr/lib:" libaac.la > libaac.la.new
	mv libaac.la.new libaac.la
	cd ${S}
	einstall
	dodoc AUTHORS ChangeLog INSTALL NEWS README README.linux TODO
}
