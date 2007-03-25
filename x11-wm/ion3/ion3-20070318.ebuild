# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion3/ion3-20070318.ebuild,v 1.1 2007/03/25 18:17:41 mabi Exp $

inherit eutils

MY_PV=${PV/_p/-}
MY_PN=ion-3ds-${MY_PV}

SCRIPTS_PV=20070322
SCRIPTS_PN=ion3-scripts

IONFLUX_PV=20061022
IONFLUX_PN=ion3-mod-ionflux

IONXRANDR_PV=20070220
IONXRANDR_PN=ion3-mod-xrandr

IONDOC_PV=20070318
IONDOC_PN=ion3-doc


DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://iki.fi/tuomov/dl/${MY_PN}.tar.gz
	mirror://gentoo/${SCRIPTS_PN}-${SCRIPTS_PV}.tar.bz2
	mirror://gentoo/${IONXRANDR_PN}-${IONXRANDR_PV}.tar.bz2
	doc?	( mirror://gentoo/${IONDOC_PN}-${IONDOC_PV}.tar.bz2 )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="unicode iontruetype doc"
DEPEND="
	|| (
		(
			x11-libs/libICE
			x11-libs/libXext
			x11-libs/libSM
			iontruetype? ( x11-libs/libXft )
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
MODULES="${IONXRANDR_PN}-${IONXRANDR_PV}"

src_unpack() {
	unpack ${A}

	cd ${S}
	EPATCH_SOURCE="${FILESDIR}/${PV}" EPATCH_SUFFIX="patch" epatch
	use iontruetype && epatch ${FILESDIR}/xft-ion3-${PV}.patch


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

	# Fix the docpath
	#sed -i system.mk build/ac/system-ac.mk.in \
	#	-e "s:\(DOCDIR=@datadir@/doc/\)@PACKAGE_TARNAME@:\1${PF}:"

	cd ${S}/build/ac/
	autoreconf -i --force

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

	cd build/ac/
	econf \
		${myconf} \
		--sysconfdir=/etc/X11 \

	cd ${S}
	make \
		DOCDIR=/usr/share/doc/${PF} || die

	for i in ${MODULES}
	do
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

	if ( use doc )
	then
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
}
