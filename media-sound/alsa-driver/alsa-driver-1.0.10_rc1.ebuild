# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-driver/alsa-driver-1.0.10_rc1.ebuild,v 1.3 2005/08/25 22:17:04 chriswhite Exp $

inherit linux-mod flag-o-matic eutils

MY_P="${P/_rc/rc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Advanced Linux Sound Architecture kernel modules"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/driver/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="oss doc"

RDEPEND="virtual/modutils
	 ~media-sound/alsa-headers-${PV}"
DEPEND="${RDEPEND}
	virtual/linux-sources
	sparc? ( >=sys-devel/autoconf-2.50 )
	sys-apps/debianutils"

PROVIDE="virtual/alsa"

pkg_setup() {
	# By default, drivers for all supported cards will be compiled.
	# If you want to only compile for specific card(s), set ALSA_CARDS
	# environment to a space-separated list of drivers that you want to build.
	# For example:
	#
	#   env ALSA_CARDS='emu10k1 intel8x0 ens1370' emerge alsa-driver
	#
	ALSA_CARDS=${ALSA_CARDS:-all}

	# Which drivers need PNP
	local PNP_DRIVERS="interwave interwave-stb"

	CONFIG_CHECK="SOUND"
	SND_ERROR="ALSA is already compiled into the kernel."
	SOUND_ERROR="Your kernel doesn't have sound support enabled."
	SOUND_PRIME_ERROR="Your kernel is configured to use the deprecated OSS drivers.  Please disable them and re-emerge alsa-driver."
	PNP_ERROR="Some of the drivers you selected require PNP in your kernel (${PNP_DRIVERS}).  Either enable PNP in your kernel or trim which drivers get compiled using ALSA_CARDS in /etc/make.conf."

	if [[ "${ALSA_CARDS}" == "all" ]]; then
		CONFIG_CHECK="${CONFIG_CHECK} PNP"
	else
		for pnpdriver in ${PNP_DRIVERS}; do
			hasq ${pnpdriver} ${ALSA_CARDS} && CONFIG_CHECK="${CONFIG_CHECK} PNP"
		done
	fi

	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}

	cd ${S}

	if use sparc ; then
		epatch ${FILESDIR}/alsa-driver-1.0.9b-sparc64-ioctl-detect.patch
		WANT_AUTOCONF=2.5 autoconf || die
	fi

	epatch ${FILESDIR}/${P}-include.patch
	convert_to_m ${S}/Makefile
}

src_compile() {
	# Should fix bug #46901
	is-flag "-malign-double" && filter-flags "-fomit-frame-pointer"

	econf $(use_with oss) \
		--with-kernel="${KV_DIR}" \
		--with-build="${KV_OUT_DIR}" \
		--with-isapnp=yes \
		--with-sequencer=yes \
		--with-cards="${ALSA_CARDS}" || die "econf failed"

	# linux-mod_src_compile doesn't work well with alsa

	# -j1 : see bug #71028
	ARCH=$(tc-arch-kernel)
	emake -j1 || die "Make Failed"
	ARCH=$(tc-arch)

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

	make DESTDIR=${D} install || die "make install failed"

	# Provided by alsa-headers now
	rm -rf ${D}/usr/include/sound

	# We have our own scripts in alsa-utils
	rm -f ${D}/etc/init.d/alsasound ${D}/etc/rc.d/init.d/alsasound

	dodoc CARDS-STATUS FAQ README WARNING TODO

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

	if kernel_is 2 6; then
		# mv the drivers somewhere they won't be killed by the kernel's make modules_install
		mv ${D}/lib/modules/${KV_FULL}/kernel/sound ${D}/lib/modules/${KV_FULL}/${PN}
		rmdir ${D}/lib/modules/${KV_FULL}/kernel &> /dev/null
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


	linux-mod_pkg_postinst

	einfo "Check out the ALSA installation guide availible at the following URL:"
	einfo "http://www.gentoo.org/doc/en/alsa-guide.xml"

	if kernel_is 2 6 && [ -e ${ROOT}/lib/modules/${KV_FULL}/kernel/sound ]; then
		# Cleanup if they had older alsa installed
		for file in $(find ${ROOT}/lib/modules/${KV_FULL}/${PN} -type f); do
			rm -f ${file//${KV_FULL}\/${PN}/${KV_FULL}\/kernel\/sound}
		done

		for dir in $(find ${ROOT}/lib/modules/${KV_FULL}/kernel/sound -type d | tac); do
			rmdir ${dir} &> /dev/null
		done
	fi
}
