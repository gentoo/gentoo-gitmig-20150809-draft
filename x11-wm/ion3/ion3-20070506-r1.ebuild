# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion3/ion3-20070506-r1.ebuild,v 1.2 2007/06/03 10:55:18 mabi Exp $

inherit eutils flag-o-matic

MY_PV=${PV/_p/-}
MY_PN=ion-3rc-${MY_PV}

SCRIPTS_PV=20070510
SCRIPTS_PN=ion3-scripts

IONFLUX_PV=20070512
IONFLUX_PN=ion3-mod-ionflux

IONXRANDR_PV=20070410
IONXRANDR_PN=ion3-mod-xrandr

IONDOC_PV=20070506
IONDOC_PN=ion-doc-3rc

DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://iki.fi/tuomov/dl/${MY_PN}.tar.gz
	mirror://gentoo/${SCRIPTS_PN}-${SCRIPTS_PV}.tar.bz2
	mirror://gentoo/${IONXRANDR_PN}-${IONXRANDR_PV}.tar.bz2
	mirror://gentoo/${IONFLUX_PN}-${IONFLUX_PV}.tar.bz2
	doc?	( http://iki.fi/tuomov/dl/${IONDOC_PN}-${IONDOC_PV}.tar.gz )"

LICENSE="LGPL-2.1+tuomov"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="unicode ion3-voidupstreamsupport-truetype doc"
DEPEND="
	|| (
		(
			x11-libs/libICE
			x11-libs/libXext
			x11-libs/libSM
			ion3-voidupstreamsupport-truetype? ( x11-libs/libXft )
		)
		virtual/x11
	)
	dev-util/pkgconfig
	app-misc/run-mailcap
	>=dev-lang/lua-5.1.1
	doc? ( dev-tex/latex2html
			virtual/tetex )"

S=${WORKDIR}/${MY_PN}

SCRIPTS_DIRS="keybindings scripts statusbar statusd styles"
MODULES="${IONXRANDR_PN}-${IONXRANDR_PV} ${IONFLUX_PN}-${IONFLUX_PV}"

src_unpack() {
	unpack ${A}

	cd ${S}
	EPATCH_SOURCE="${FILESDIR}/${PV}" EPATCH_SUFFIX="patch" epatch
	if (use ion3-voidupstreamsupport-truetype); then
		epatch ${FILESDIR}/xft-ion3-${PV}.patch

		sed -i -e "s:#USE_XFT=1:USE_XFT=1:" ${S}/system.mk
		sed -i -e 's:\(#define ION_VERSION
		"3rc-20070506\):\1-gentoo-xft-enabled:' ${S}/version.h
	fi;

	# Allow user CFLAGS
	sed -i "s:\(CFLAGS=\)-g -Os\(.*\):\1\2 ${CFLAGS}:" system.mk

	# Allow user LDFLAGS
	sed -i "s:\(LDFLAGS=\)-g -Os\(.*\):\1\2 ${LDFLAGS}:" system.mk

	# Don't strip ionflux
	sed -i "s:-s::" "../${IONFLUX_PN}-${IONFLUX_PV}/ionflux/Makefile"

	# Make snprintf avaible to ion-completefile
	sed -i 's:\(CFLAGS +=.*\):\1 $(C99_SOURCE):' utils/ion-completefile/Makefile

	# Rewrite install directories to be prefixed by DESTDIR for sake of portage's sandbox
	sed -i 's!\($(INSTALL\w*)\|rm -f\|ln -s\)\(.*\)\($(\w\+DIR)\)!\1\2$(DESTDIR)\3!g' Makefile */Makefile */*/Makefile build/rules.mk

	for i in ${MODULES}
	do
		cd ${WORKDIR}/${i}
		# Rewrite install directories to be prefixed by DESTDIR for sake of portage's sandbox
		sed -i Makefile */Makefile \
			-e 's!\($(INSTALL\w*)\|rm -f\|ln -s\)\(.*\)\($(\w\+DIR)\)!\1\2$(DESTDIR)\3!g'

	done
	cd ${S}

	# Hey guys! Implicit rules apply to include statements also. Be more careful!
	# Fix an implicit rule that will kill the installation by rewriting a .mk
	# should configure be given just the right set of options.
	sed -i 's!%: %.in!ion-completeman: %: %.in!g' utils/Makefile

	# Fix prestripping of files
	sed -i mod_statusbar/ion-statusd/Makefile utils/ion-completefile/Makefile \
		-e 's: -s::'

	# FIX for modules
	cd ${WORKDIR}
	ln -s ${MY_PN} ion-3
}

src_compile() {
	local myconf=""

	# xfree 
	if has_version '>=x11-base/xfree-4.3.0'; then
		sed -i -e "s:DEFINES += -DCF_XFREE86_TEXTPROP_BUG_WORKAROUND:#DEFINES += -DCF_XFREE86_TEXTPROP_BUG_WORKAROUND:" ${S}/system.mk
	fi

	# help out this arch as it can't handle certain shared library linkage
	use hppa && sed -i -e "s:#PRELOAD_MODULES=1:PRELOAD_MODULES=1:" ${S}/system.mk

	# unicode support
	use unicode && sed -i -e "s:#DEFINES += -DCF_DE_USE_XUTF8:DEFINES += -DCF_DE_USE_XUTF8:" ${S}/system.mk

	cd ${S}
	make \
		LIBDIR=/usr/$(get_libdir) \
		DOCDIR=/usr/share/doc/${PF} || die

	for i in ${MODULES}
	do
		cd ${WORKDIR}/${i}

		make \
			LIBDIR=/usr/$(get_libdir)
	done

	if ( use doc )
	then
		export MT_FEATURES=varfonts
		mkdir -p ${T}/var/cache/fonts
		export VARTEXFONTS=${T}/var/cache/fonts

		cd ${WORKDIR}/${IONDOC_PN}-${IONDOC_PV}
		make all
		make all-pdf
	fi
}

src_install() {

	emake \
		DESTDIR=${D} \
		DOCDIR=/usr/share/doc/${PF} \
	install || die

	echo -e "#!/bin/sh\n/usr/bin/ion3" > ${T}/ion3
	echo -e "#!/bin/sh\n/usr/bin/pwm3" > ${T}/pwm3
	exeinto /etc/X11/Sessions
	doexe ${T}/ion3 ${T}/pwm3

	insinto /usr/share/xsessions
	doins ${FILESDIR}/ion3.desktop ${FILESDIR}/pwm3.desktop

	cd ${WORKDIR}/${SCRIPTS_PN}-${SCRIPTS_PV}
	insinto /usr/share/ion3
	find $SCRIPTS_DIRS -type f |\
		while read FILE
		do
			doins $PWD/$FILE
		done

	for i in ${MODULES}
	do
		cd ${WORKDIR}/${i}

		emake \
			DESTDIR=${D} \
			install || die

	done

	if ( use doc )
	then
		cd ${WORKDIR}/${IONDOC_PN}-${IONDOC_PV}
		dodoc *.pdf
	fi

	sed -i -e '/dopath("mod_sp")/a\dopath("mod_xrandr")' ${D}/etc/X11/ion3/cfg_defaults.lua
}

pkg_postinst() {
	elog "This version of ion3 contains no xinerama support (removed upstream)."
	elog "Remember that USE='ion3-voidupstreamsupport-truetype' will render"
	elog "upstream support for your installation of ion3 void."
	elog "Thus, if you encouter a bug in ion-3, be sure to to reproduce it with a"
	elog "vanilla build before reporting it upstream. You are welcome to report"
	elog "any problem as a bug on http://bugs.gentoo.org."
}
