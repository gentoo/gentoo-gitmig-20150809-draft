# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion3/ion3-20061223.ebuild,v 1.5 2007/03/26 16:11:50 armin76 Exp $

inherit autotools eutils

MY_PV=${PV/_p/-}
MY_PN=ion-3ds-${MY_PV}

SCRIPTS_PV=20061214
SCRIPTS_PN=ion3-scripts

IONFLUX_PV=20061022
IONFLUX_PN=ion3-mod-ionflux

IONXRANDR_PV=20061021
IONXRANDR_PN=ion3-mod-xrandr


DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://iki.fi/tuomov/dl/${MY_PN}.tar.gz
	mirror://debian/pool/main/i/${SCRIPTS_PN}/${SCRIPTS_PN}_${SCRIPTS_PV}.orig.tar.gz
	mirror://debian/pool/main/i/${IONFLUX_PN}/${IONFLUX_PN}_${IONFLUX_PV}.orig.tar.gz
	mirror://gentoo/${IONXRANDR_PN}-${IONXRANDR_PV}.tar.bz2
	iontruetype? (
	http://clemens.endorphin.org/patches/xft-ion3-for-darcs-20061202.diff )"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="xinerama unicode iontruetype"
DEPEND="
	|| (
		(
			x11-libs/libICE
			x11-libs/libXext
			x11-libs/libSM
			iontruetype? ( x11-libs/libXft )
			xinerama? ( x11-libs/libXinerama )
		)
		virtual/x11
	)
	app-misc/run-mailcap
	>=dev-lang/lua-5.1.1"
S=${WORKDIR}/${MY_PN}

SCRIPTS_DIRS="keybindings scripts statusbar statusd styles"

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_SOURCE="${FILESDIR}/${PV}" EPATCH_SUFFIX="patch" epatch

#	use iontruetype && epatch ${DISTDIR}/xft-ion3-for-darcs-20061202.diff
	use iontruetype && patch -p1 < ${DISTDIR}/xft-ion3-for-darcs-20061202.diff

	# Rewrite install directories to be prefixed by DESTDIR for sake of portage's sandbox
	sed -i Makefile */Makefile */*/Makefile build/rules.mk \
		-e 's!\($(INSTALL\w*)\|rm -f\|ln -s\)\(.*\)\($(\w\+DIR)\)!\1\2$(DESTDIR)\3!g'

	for i in "${IONFLUX_PN}-${IONFLUX_PV}" "${IONXRANDR_PN}-${IONXRANDR_PV}"
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

	cd ${S}/build/ac/
	# for the first instance of DEFINES, add XINERAMA
	use xinerama && \
	(
		sed -i 's!\(DEFINES *+=\)!\1 -DCF_XINERAMA !' system-ac.mk.in
		sed -i 's!\(LIBS="$LIBS.*\)"!\1 $XINERAMA_LIBS"!' configure.ac
	)

	cd ${S}/build/ac/
	eautoreconf

	# FIX for modules
	cd ${WORKDIR}
	ln -s ${MY_PN} ion-3
}

src_compile() {
	local myconf=""

	myconf="${myconf} `use_enable iontruetype xft`"

	# xfree
	if has_version '>=x11-base/xfree-4.3.0'; then
		myconf="${myconf} --disable-xfree86-textprop-bug-workaround"
	fi

	# help out this arch as it can't handle certain shared library linkage
	use hppa && myconf="${myconf} --disable-shared"

	# unicode support
	use unicode && myconf="${myconf} --enable-Xutf8"

	# configure bug, only specify xinerama to not have it
	myconf="${myconf}  `use_enable xinerama`"

	cd build/ac/
#	${S}/build/ac/configure \
	econf \
		${myconf} \
		--sysconfdir=/etc/X11 \
		--with-lua-prefix=/usr

	cd ${S}
	make \
		DOCDIR=/usr/share/doc/${PF} || die

	for i in "${IONFLUX_PN}-${IONFLUX_PV}" "${IONXRANDR_PN}-${IONXRANDR_PV}" ; do
		cd ${WORKDIR}/${i}

		emake \
			prefix=/usr \
			ETCDIR=/etc/X11/ion3 \
			SHAREDIR=/usr/share/ion3 \
			MANDIR=/usr/share/man \
			DOCDIR=/usr/share/doc/${PF} \
			LOCALEDIR=/usr/share/locale \
			LIBDIR=/usr/lib \
			MODULEDIR=/usr/lib/ion3/mod \
			LCDIR=/usr/lib/ion3/lc \
		VARDIR=/var/cache/ion3
	done
}

src_install() {

	emake \
		DESTDIR=${D} \
	install || die

	prepalldocs

	echo -e "#!/bin/sh\n/usr/bin/ion3" > ${T}/ion3
	echo -e "#!/bin/sh\n/usr/bin/pwm3" > ${T}/pwm3
	exeinto /etc/X11/Sessions
	doexe ${T}/ion3 ${T}/pwm3

	insinto /usr/share/xsessions
	doins ${FILESDIR}/ion3.desktop ${FILESDIR}/pwm3.desktop

	cd ${WORKDIR}/${SCRIPTS_PN}-${SCRIPTS_PV}
	insinto /usr/share/ion3
	find $SCRIPTS_DIRS -type f |\
		while read FILE ; do
			doins $PWD/$FILE
		done

#	dodir /usr/share/ion3
#	cp -R * ${D}/usr/share/ion3

	for i in "${IONFLUX_PN}-${IONFLUX_PV}" "${IONXRANDR_PN}-${IONXRANDR_PV}" ; do
		cd ${WORKDIR}/${i}

		emake \
			DESTDIR=${D} \
			install || die

	done

	echo '--dopath("mod_ionflux")' >> ${D}/etc/X11/ion3/cfg_modules.lua
	echo 'dopath("mod_xrandr")' >> ${D}/etc/X11/ion3/cfg_modules.lua
}
