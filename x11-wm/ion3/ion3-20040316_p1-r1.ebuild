# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion3/ion3-20040316_p1-r1.ebuild,v 1.3 2004/09/05 18:40:11 gmsoft Exp $

inherit eutils

MY_PV=${PV/_p/-}
MY_PN=ion-3ds-${MY_PV}
DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://modeemi.fi/~tuomov/dl/${MY_PN}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~ppc ~sparc ~x86 ~amd64 ~hppa"
IUSE="xinerama"
DEPEND="virtual/x11
	app-misc/run-mailcap
	>=dev-lang/lua-5.0.2
	>=sys-devel/libtool-1.4.3
	!x11-wm/ion3-svn"
S=${WORKDIR}/${MY_PN}

src_compile() {

	epatch ${FILESDIR}/ion3-20040316_p1-rename.patch

	local myconf=""

	if has_version '>=x11-base/xfree-4.3.0'; then
		myconf="${myconf} --disable-xfree86-textprop-bug-workaround"
	fi

	autoreconf

	use hppa && myconf="${myconf} --disable-shared"

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
		ETCDIR=${D}/etc/X11/ion3 \
		SHAREDIR=${D}/usr/share/ion3 \
		MANDIR=${D}/usr/share/man \
		DOCDIR=${D}/usr/share/doc/${PF} \
		install || die

	mv ${D}/usr/bin/ion ${D}/usr/bin/ion3
	mv ${D}/usr/bin/pwm ${D}/usr/bin/pwm3
	mv ${D}/usr/share/man/man1/ion.1 ${D}/usr/share/man/man1/ion3.1
	mv ${D}/usr/share/man/man1/pwm.1 ${D}/usr/share/man/man1/pwm3.1

	prepalldocs

	insinto /usr/include/ion3
	doins *.h *.mk mkexports.lua
	for i in de ioncore luaextl mod_floatws mod_ionws mod_menu mod_query mod_sm mod_sp; do
		insinto /usr/include/ion3/${i}
		doins ${i}/*.h
	done

	echo -e "#!/bin/sh\n/usr/bin/ion3" > ${T}/ion3
	echo -e "#!/bin/sh\n/usr/bin/pwm3" > ${T}/pwm3
	exeinto /etc/X11/Sessions
	doexe ${T}/ion3 ${T}/pwm3

	insinto /usr/share/xsessions
	doins ${FILESDIR}/ion3.desktop ${FILESDIR}/pwm3.desktop

}

pkg_postinst() {
	ewarn Binaries, directories, etc. have been renamed from ion to ion3.
	ewarn You might need to update your configuration files.
}
