# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-driver/alsa-driver-1.0.7-r4.ebuild,v 1.10 2005/04/04 22:30:57 eradicator Exp $

IUSE="oss doc"
inherit linux-mod flag-o-matic eutils

MY_P=${P/_rc/rc}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Advanced Linux Sound Architecture kernel modules"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/driver/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~mips ~ppc sparc x86"

RDEPEND="virtual/modutils
	 ~media-sound/alsa-headers-${PV}"

DEPEND="${RDEPEND}
	sys-devel/patch
	virtual/linux-sources
	>=sys-devel/autoconf-2.50
	sys-apps/debianutils"

PROVIDE="virtual/alsa"




pkg_setup() {
	CONFIG_CHECK="SOUND !SND !SOUND_PRIME"
	SND_ERROR="ALSA is already compiled into the kernel."
	SOUND_ERROR="Your kernel doesn't have sound support enabled."
	SOUND_PRIME_ERROR="Your kernel is configured to use the deprecated OSS drivers.  Please disable them and re-emerge alsa-driver."

	linux-mod_pkg_setup

	# By default, drivers for all supported cards will be compiled.
	# If you want to only compile for specific card(s), set ALSA_CARDS
	# environment to a space-separated list of drivers that you want to build.
	# For example:
	#
	#   env ALSA_CARDS='emu10k1 intel8x0 ens1370' emerge alsa-driver
	#
	linux_chkconfig_present PNP || export PNP_DRIVERS="interwave interwave-stb"

	if [ -z "${ALSA_CARDS}" ]
	then
		ALSA_CARDS=all
		if [ -n "${PNP_DRIVERS}" ]
		then
			ewarn "Drivers have been disabled."
			ewarn "They require CONFIG_PNP in the kernel: ${PNP_DRIVERS}"
		fi
	else
		for pnpdriver in ${PNP_DRIVERS}
		do
			# check for pnp drivers in ALSA_CARDS
			[ `expr match ${pnpdriver} "${ALSA_CARDS}"` -gt 0 ] && \
				die "Driver ${pnpdriver} needs CONFIG_PNP."
		done
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-1.0.5-devfix.patch

	[ "${PROFILE_ARCH}" == "xbox" ] && \
		epatch ${FILESDIR}/${PN}-1.0.7-xbox.patch

	convert_to_m ${S}/Makefile

	# Fix ioctl32 support
	epatch ${FILESDIR}/${P}-ioctl32.patch-r2

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
		--with-build="${KV_OUT_DIR}" \
		--with-isapnp=yes \
		--with-sequencer=yes \
		--with-cards="${ALSA_CARDS}" || die "econf failed"

	# linux-mod_src_compile doesn't work well with alsa

	local myconf
	if [ -n "${PNP_DRIVERS}" ]
	then
		myconf=$(echo ${PNP_DRIVERS//-/_} | sed -e 's/[a-z_]*/CONFIG_SND_\U&\E=n/g')
	fi

	set_arch_to_kernel
	# -j1 : see bug #71028
	emake -j1  ${myconf} || die "Make Failed"
	set_arch_to_portage

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

	local myconf
	if [ -n "${PNP_DRIVERS}" ]
	then
		myconf=$(echo ${PNP_DRIVERS//-/_} | sed -e 's/[a-z_]*/CONFIG_SND_\U&\E=n/g')
	fi

	make DESTDIR=${D} ${myconf} install || die

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

	if [ -n "${PNP_DRIVERS}" ]
	then
		einfo "some drivers haven't been built due to them requiring CONFIG_PNP in the kernel: ${PNP_DRIVERS}"
	fi

	linux-mod_pkg_postinst

	einfo "Check out the ALSA installation guide availible at the following URL:"
	einfo "http://www.gentoo.org/doc/en/alsa-guide.xml"
}
