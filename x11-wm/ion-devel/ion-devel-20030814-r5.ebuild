# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion-devel/ion-devel-20030814-r5.ebuild,v 1.1 2003/11/10 17:02:18 twp Exp $

MY_P=${PN}-${PV/_p/-}
DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://modeemi.fi/~tuomov/dl/${MY_P}.tar.gz"
LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="xinerama"
DEPEND="virtual/x11
	app-misc/run-mailcap
	>=dev-lang/lua-5"
S=${WORKDIR}/${MY_P}

inherit eutils

src_unpack() {

	unpack ${A}

	cd ${S}

	epatch ${FILESDIR}/system.mk-${PV}-no-utf8.patch
	epatch ${FILESDIR}/stripws-${PV}.patch
	epatch ${FILESDIR}/tabdrag-${PV}.patch
	epatch ${FILESDIR}/stacking-${PV}.patch
	epatch ${FILESDIR}/find-suitable-screen-${PV}.patch

	sed -i system.mk \
		-e "s/@CFLAGS@/${CFLAGS}/g" \
		-e "s/@PF@/${PF}/g"
	if [ `use xinerama` ]; then
		einfo Enabling Xinerama support
		eend 0
	else
		einfo Disabling Xinerama support
		sed -i system.mk \
			-e 's/\(XINERAMA_LIBS=-lXinerama\)/#\1/' \
			-e 's/#\(DEFINES += -DCF_NO_XINERAMA\)/\1/'
		eend $?
	fi

	if has_version '<x11-base/xfree-4.3.0'; then
		einfo Enabling Xfree\<4.3.0/Opera/UTF-8 bug workaround
		eend 0
	else
		einfo Disabling Xfree\<4.3.0/Opera/UTF-8 bug workaround
		sed -i system.mk \
			-e 's/\(DEFINES += -DCF_XFREE86_TEXTPROP_BUG_WORKAROUND\)/#\1/'
		eend $?
	fi

}

src_compile() {
	emake || die
}

src_install() {

	make PREFIX=${D}/usr ETCDIR=${D}/etc/X11/ion-devel install || die
	dobin scripts/pwm

	echo -e "#!/bin/sh\n/usr/bin/ion" > ${T}/ion-devel
	echo -e "#!/bin/sh\n/usr/bin/pwm" > ${T}/pwm
	exeinto /etc/X11/Sessions
	doexe ${T}/ion-devel ${T}/pwm

}

pkg_postinst() {
	ewarn The configuration file format has changed. You may have to re-write your
	ewarn configuration files.
	ewarn To delete stale system-wide configuration files, run the command:
	ewarn "\trm -f ${R}/etc/X11/ion-devel/*.conf"
}
