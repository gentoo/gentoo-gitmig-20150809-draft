# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-driver/alsa-driver-1.0.7-r1.ebuild,v 1.7 2004/11/27 12:17:30 eradicator Exp $

IUSE="oss doc"

inherit linux-mod flag-o-matic eutils

MY_P=${P/_rc/rc}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Advanced Linux Sound Architecture kernel modules"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/driver/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"

RDEPEND="virtual/modutils
		~media-sound/alsa-headers-${PV}"

DEPEND="${RDEPEND}
		sys-devel/patch
		virtual/linux-sources
		>=sys-devel/autoconf-2.50
		sys-apps/debianutils"

PROVIDE="virtual/alsa"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-1.0.5-devfix.patch
	epatch ${FILESDIR}/${PN}-1.0.5a-cs46xx-passthrough.patch

	[ "${PROFILE_ARCH}" == "xbox" ] && \
		epatch ${FILESDIR}/${PN}-1.0.5a-xbox-ac97.patch

	convert_to_m ${S}/Makefile

	# Fix ioctl32 support
	epatch ${FILESDIR}/${P}-ioctl32.patch-r1

	# Fix audigy 7.1 detection on some cards... bug #72433
	epatch ${FILESDIR}/${P}-audigy71.patch

	# Fix order of configure operations so the kernel compiler isn't used
	# for tests.
	epatch ${FILESDIR}/${PN}-1.0.7-configure.patch
	export WANT_AUTOCONF=2.5
	autoconf
}

src_compile() {
	# Should fix bug #46901
	is-flag "-malign-double" && filter-flags "-fomit-frame-pointer"

	econf `use_with oss` \
		--with-kernel="${KV_DIR}" \
		--with-build="${KER_DIR}" \
		--with-isapnp=yes \
		--with-sequencer=yes \
		--with-cards="${ALSA_CARDS}" || die "econf failed"

	# linux-mod_src_compile doesn't work well with alsa
	unset ARCH
	# -j1 : see bug #71028
	emake -j1 || die "Parallel Make Failed"

	if use doc;
	then
		ebegin "Building Documentation"
		cd ${S}/scripts
		emake || die Failed making docs in ${S}/scripts

		cd ${S}/doc/DocBook
		emake || die Failed making docs in ${S}/doc/DocBook
		eend $?
	fi
}


src_install() {
	dodir /usr/include/sound
	make DESTDIR=${D} install || die

	# Provided by alsa-headers now
	rm -rf ${D}/usr/include/sound

	# We have our own scripts in alsa-utils
	test -e ${D}/etc/init.d/alsasound && rm ${D}/etc/init.d/alsasound
	test -e ${D}/etc/rc.d/init.d/alsasound && rm ${D}/etc/rc.d/init.d/alsasound

	dodoc CARDS-STATUS INSTALL FAQ README WARNING TODO

	if use doc; then
		docinto doc
		dodoc doc/*
		rm ${D}/usr/share/doc/${PF}/doc/Makefile.gz

		docinto DocBook
		dodoc doc/DocBook/*
		rm ${D}/usr/share/doc/${PF}/DocBook/Makefile.gz

		docinto Documentation
		dodoc sound/Documentation/*
	fi
}

pkg_setup() {
	CONFIG_CHECK="CONFIG_SOUND !CONFIG_SND"

	linux-mod_pkg_setup

	# By default, drivers for all supported cards will be compiled.
	# If you want to only compile for specific card(s), set ALSA_CARDS
	# environment to a space-separated list of drivers that you want to build.
	# For example:
	#
	#   env ALSA_CARDS='emu10k1 intel8x0 ens1370' emerge alsa-driver
	#
	[ -z "${ALSA_CARDS}" ] && ALSA_CARDS=all
}

pkg_postinst() {
	einfo
	einfo "The alsasound initscript and modules.d/alsa have now moved to alsa-utils"
	einfo
	einfo "Also, remember that all mixer channels will be MUTED by default."
	einfo "Use the 'alsamixer' program to unmute them."
	einfo
	einfo "Version 1.0.3 and above should work with version 2.6 kernels."
	einfo "If you experience problems, please report bugs to http://bugs.gentoo.org."
	einfo

	linux-mod_pkg_postinst
}
