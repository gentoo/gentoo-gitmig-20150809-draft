# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion3/ion3-20070203.ebuild,v 1.2 2007/03/26 16:11:50 armin76 Exp $

inherit eutils

MY_PV=${PV/_p/-}
MY_PN=ion-3ds-${MY_PV}

SCRIPTS_PV=20070203
SCRIPTS_PN=ion3-scripts

IONXRANDR_PV=20061021
IONXRANDR_PN=ion3-mod-xrandr


DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://iki.fi/tuomov/dl/${MY_PN}.tar.gz
	mirror://debian/pool/main/i/${SCRIPTS_PN}/${SCRIPTS_PN}_${SCRIPTS_PV}.orig.tar.gz
	mirror://gentoo/${IONXRANDR_PN}-${IONXRANDR_PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="unicode"
DEPEND="
	|| (
		(
			x11-libs/libICE
			x11-libs/libXext
			x11-libs/libSM
		)
		virtual/x11
	)
	app-misc/run-mailcap
	>=dev-lang/lua-5.1.1"
S=${WORKDIR}/${MY_PN}

SCRIPTS_DIRS="keybindings scripts statusbar statusd styles"
MODULES="${IONXRANDR_PN}-${IONXRANDR_PV}"

src_unpack() {
	unpack ${A}

	cd ${S}
	EPATCH_SOURCE="${FILESDIR}/${PV}" EPATCH_SUFFIX="patch" epatch

	# Rewrite install directories to be prefixed by DESTDIR for sake of portage's sandbox
	sed -i Makefile */Makefile */*/Makefile build/rules.mk \
		-e 's!\($(INSTALL\w*)\|rm -f\|ln -s\)\(.*\)\($(\w\+DIR)\)!\1\2$(DESTDIR)\3!g'

	for i in ${MODULES}
	do
		cd ${WORKDIR}/${i}
		# Rewrite install directories to be prefixed by DESTDIR for sake of portage's sandbox
		sed -i Makefile \
			-e 's!\($(INSTALL\w*)\|rm -f\|ln -s\)\(.*\)\($(\w\+DIR)\)!\1\2$(DESTDIR)\3!g'

	done
	cd ${S}

	# Hey guys! Implicit rules apply to include statements also. Be more careful!
	# Fix an implicit rule that will kill the installation by rewriting a .mk
	# should configure be given just the right set of options.
	sed -i 's!%: %.in!ion-completeman: %: %.in!g' utils/Makefile

	cd ${S}/build/ac/
	autoreconf -i --force

	# FIX for modules
	cd ${WORKDIR}
	ln -s ${MY_PN} ion-3
}

src_compile() {
	local myconf=""

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
		--sysconfdir=/etc/X11

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

	for i in ${MODULES} ; do
		cd ${WORKDIR}/${i}

		emake \
			DESTDIR=${D} \
			install || die

	done

	echo 'dopath("mod_xrandr")' >> ${D}/etc/X11/ion3/cfg_modules.lua

	mv ${D}/usr/share/doc/ion3 ${D}/usr/share/doc/${PF}
}

pkg_postinst() {
	elog "Please note that this release does *not* include xinerama support
	anymore."
	elog "Support for that feature has been dropped upstream."
	elog "Also, xft (via iontruetype) is gone, in a bid to close the gap to
	upstream."
}
