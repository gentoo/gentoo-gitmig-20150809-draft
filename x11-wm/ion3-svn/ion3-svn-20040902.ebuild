# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion3-svn/ion3-svn-20040902.ebuild,v 1.1 2004/09/02 11:53:10 twp Exp $

inherit eutils subversion

DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="xinerama"
DEPEND="virtual/x11
	app-misc/run-mailcap
	>=dev-lang/lua-5.0.2
	>=sys-devel/libtool-1.4.3
	>=dev-libs/libtu-svn-20040902
	!x11-wm/ion3"

ESVN_REPO_URI="http://tao.uab.es/ion/svn/ion/trunk"
ESVN_PROJECT="ion-snapshot"

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
		PREFIX=${D}/usr \
		ETCDIR=${D}/etc/X11/ion3 \
		SHAREDIR=${D}/usr/share/ion3 \
		MANDIR=${D}/usr/share/man \
		DOCDIR=${D}/usr/share/doc/${PF} \
		LOCALEDIR=${D}/usr/share/locale \
		install || die

	prepalldocs

	insinto /usr/include/ion3
	doins *.h *.mk
	insinto /usr/include/ion3/build
	doins build/mkexports.lua
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
