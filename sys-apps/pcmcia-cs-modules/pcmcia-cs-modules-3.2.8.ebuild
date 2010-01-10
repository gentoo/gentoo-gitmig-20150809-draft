# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs-modules/pcmcia-cs-modules-3.2.8.ebuild,v 1.4 2010/01/10 01:20:24 robbat2 Exp $

inherit eutils flag-o-matic toolchain-funcs linux-mod

MY_P=${P/-modules/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="PCMCIA modules for Linux 2.4.x"
HOMEPAGE="http://pcmcia-cs.sourceforge.net"
SRC_URI="mirror://sourceforge/pcmcia-cs/${MY_P}.tar.gz
		http://ozlabs.org/people/dgibson/dldwd/monitor-0.13e.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE="cardbus"
DEPEND="virtual/linux-sources
		app-arch/tar
		>=sys-apps/sed-4"
RDEPEND=""

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is gt 2 4; then
		eerror
		eerror "This package only works with linux-2.4.x"
		eerror "For newer kernels, please use the in-kernel PCMCIA drivers."
		eerror
		die "linux-${KV_FULL} detected"
	fi

	if (linux_chkconfig_present PCMCIA || linux_chkconfig_present PCCARD); then
		eerror
		eerror "This package requires the in-kernel PCMCIA drivers to be disabled."
		eerror
		die "Kernel PCMCIA support detected"
	fi
}

src_unpack() {
	unpack ${MY_P}.tar.gz

	cd ${S}/wireless
	epatch ${DISTDIR}/monitor-0.13e.patch

	cd ${S}
	epatch ${FILESDIR}/${MY_P}-orinoco-gcc34.patch
	epatch ${FILESDIR}/${MY_P}-modules-only.patch
}

src_compile() {
	local config CONFIG_FILE

	if use cardbus; then
		einfo "CardBus support enabled"
		config="${config} --cardbus"
	else
		einfo "CardBus support disabled"
		config="${config} --nocardbus"
	fi

	if linux_chkconfig_present PM; then
		einfo "Power management support enabled"
		config="${config} --apm"
	else
		einfo "Power management support disabled"
		config="${config} --noapm"
	fi

	if linux_chkconfig_present PNP; then
		einfo "Plug and Play support enabled"
		config="${config} --pnp"
	else
		einfo "Plug and Play support disabled"
		config="${config} --nopnp"
	fi

	${S}/Configure \
		--noprompt \
		--kernel=${KV_DIR} \
		--moddir=/lib/modules/${KV_FULL} \
		--target=${D} \
		--arch=$(tc-arch-kernel) \
		--ucc=$(tc-getCC) \
		--kcc=$(tc-getCC) \
		--ld=$(tc-getLD) \
		--uflags="${CFLAGS}" \
		--kflags="$(getfilevar HOSTCFLAGS ${KV_DIR}/Makefile)" \
		--srctree \
		--nox11 \
		${config} \
		|| die "Configure failed"

	ebegin "Saving pcmcia-cs development environment"
	echo ${PV} > ${S}/pcmcia-cs-version
	cd ${S}
	tar -cjf ${T}/pcmcia-cs-build-env.tbz2 .
	eend ${?}

	emake all || die "emake all failed"
}

src_install () {
	emake install || die "emake install failed"

	# remove bogus modules.conf file
	rm -f ${D}/etc/modules.conf

	# install the pcmcia-cs development environment tarball
	# (used by linux-mod.eclass)
	insinto /usr/src/pcmcia-cs
	doins ${T}/pcmcia-cs-build-env.tbz2
}

pkg_postinst() {
	einfo
	einfo "It is adviced that you re-merge all external PCMCIA modules"
	einfo "after installing a new version of ${PN}."
	einfo
}
