# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion-devel/ion-devel-20030814.ebuild,v 1.1 2003/08/18 13:55:43 twp Exp $

MY_P=${PN}-${PV/_p/-}
DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://modeemi.fi/~tuomov/dl/${MY_P}.tar.gz"
LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="truetype xinerama"
DEPEND="virtual/x11
	app-misc/run-mailcap
	>=dev-lang/lua-5
	truetype? ( virtual/xft )"
S=${WORKDIR}/${MY_P}

inherit eutils

src_compile() {

	epatch ${FILESDIR}/system.mk-${PV}.patch

	cp system.mk ${T}/system.mk
	sed -e "s/@CFLAGS@/${CFLAGS}/g" \
		-e "s/@PF@/${PF}/g" \
		${T}/system.mk > system.mk

	if [ `use truetype` ]; then
		einfo Enabling TrueType support
		local xft_config=`which xft-config 2> /dev/null`
		if [ -n "${xft_config}" ] && [ -x "${xft_config}" ]; then
			local xft_cflags=`${xft_config} --cflags`
			local xft_libs=`${xft_config} --libs`
		else
			local xft_cflags=
			local xft_libs="-lXft"
		fi
		cp system.mk ${T}/system.mk
		sed -e 's:#\(DEFINES += -DCF_XFT\):\1:' \
			-e "s:#\\(X11_INCLUDES += \\)\`xft-config --cflags\`:\\1${xft_cflags}:" \
			-e "s:#\\(X11_LIBS += \\)\`xft-config --libs\`:\\1${xft_libs}:" \
			${T}/system.mk > system.mk
		eend $?
	else
		einfo Disabling TrueType support
		# disabled by default
		eend 0
	fi

	if [ `use xinerama` ]; then
		einfo Enabling Xinerama support
		# enabled by default
		eend 0
	else
		einfo Disabling Xinerama support
		cp system.mk ${T}/system.mk
		sed -e 's/\(XINERAMA_LIBS=-lXinerama\)/#\1/' \
			-e 's/#\(DEFINES += -DCF_NO_XINERAMA\)/\1/' \
			${T}/system.mk > system.mk
		eend $?
	fi

	if has_version '<x11-base/xfree-4.3.0'; then
		einfo Enabling Xfree\<4.3.0/Opera/UTF-8 bug workaround
		# enabled by default
		eend 0
	else
		einfo Disabling Xfree\<4.3.0/Opera/UTF-8 bug workaround
		cp system.mk ${T}/system.mk
		sed -e 's/\(DEFINES += -DCF_XFREE86_TEXTPROP_BUG_WORKAROUND\)/#\1/' \
			${T}/system.mk > system.mk
		eend $?
	fi
	
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
	ewarn "\trm -f ${R}etc/X11/ion-devel\*.conf"
}
