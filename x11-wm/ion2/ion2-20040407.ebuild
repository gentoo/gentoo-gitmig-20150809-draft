# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion2/ion2-20040407.ebuild,v 1.1 2004/04/07 20:57:59 twp Exp $

inherit eutils

DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://modeemi.fi/~tuomov/ion/dl/ion-2-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~mips ~ppc ~sparc ~x86"
IUSE="xinerama"
DEPEND="virtual/x11
	app-misc/run-mailcap
	>=dev-lang/lua-5.0.2
	>=sys-devel/libtool-1.4.3
	!<=x11-wm/ion2-20040211-r2"
S=${WORKDIR}/ion-2-${PV}

src_unpack() {

	unpack ${A}

	cd ${S}

	epatch ${FILESDIR}/ion2-20040407-rename.patch

}

src_compile() {

	local myconf=""

	if has_version '>=x11-base/xfree-4.3.0'; then
		myconf="${myconf} --disable-xfree86-textprop-bug-workaround"
	fi

	autoreconf

	econf \
		--sysconfdir=/etc/X11 \
		`use_enable xinerama` \
		${myconf} || die

	emake \
		DOCDIR=/usr/share/doc/${PF} || die

}

src_install() {

	make \
		prefix=${D}/usr \
		ETCDIR=${D}/etc/X11/ion2 \
		SHAREDIR=${D}/usr/share/ion2 \
		MANDIR=${D}/usr/share/man \
		DOCDIR=${D}/usr/share/doc/${PF} \
		install || die

	mv ${D}/usr/bin/ion ${D}/usr/bin/ion2
	mv ${D}/usr/bin/pwm ${D}/usr/bin/pwm2
	mv ${D}/usr/share/man/man1/ion.1 ${D}/usr/share/man/man1/ion2.1
	mv ${D}/usr/share/man/man1/pwm.1 ${D}/usr/share/man/man1/pwm2.1

	prepalldocs

	insinto /usr/include/ion2
	doins *.h *.mk mkexports.lua
	for i in de floatws ioncore ionws luaextl menu query; do
		insinto /usr/include/ion2/${i}
		doins ${i}/*.h
	done
	insinto /usr/include/ion2/libtu
	doins libtu/*.h

	echo -e "#!/bin/sh\n/usr/bin/ion2" > ${T}/ion2
	echo -e "#!/bin/sh\n/usr/bin/pwm2" > ${T}/pwm2
	exeinto /etc/X11/Sessions
	doexe ${T}/ion2 ${T}/pwm2

	insinto /usr/share/xsessions
	doins ${FILESDIR}/ion2.desktop ${FILESDIR}/pwm2.desktop

}

pkg_postinst() {
	ewarn "Binaries and manual pages have been renamed to ion2"
	ewarn "You might have to edit your .xsession/.xinitrc."
}
