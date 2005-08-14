# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs/pcmcia-cs-3.2.8-r2.ebuild,v 1.4 2005/08/14 10:02:07 hansmi Exp $

inherit eutils flag-o-matic toolchain-funcs linux-info

DESCRIPTION="PCMCIA tools for Linux"
HOMEPAGE="http://pcmcia-cs.sourceforge.net"
SRC_URI="mirror://sourceforge/pcmcia-cs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

IUSE="gtk gtk2 vanilla trusted X xforms"
RDEPEND="!sys-apps/pcmcia-cs-cis
			X? ( virtual/x11
			gtk? ( gtk2? ( =x11-libs/gtk+-2*
						   dev-util/pkgconfig )
				    !gtk2? ( =x11-libs/gtk+-1* ) )
			xforms? ( x11-libs/xforms ) )"
DEPEND="${RDEPEND}
		virtual/linux-sources
		>=sys-apps/sed-4"
PROVIDE="virtual/pcmcia"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 5 && linux_chkconfig_present PCMCIA; then
		ewarn
		ewarn "The recommended configuration for linux-2.4.x is to disable"
		ewarn "CONFIG_PCMCIA in the kernel and use the drivers from"
		ewarn "sys-apps/pcmcia-cs-modules."
		ewarn
	elif kernel_is gt 2 4 && ! (linux_chkconfig_present PCMCIA || linux_chkconfig_present PCCARD); then
		eerror
		eerror "The package requires the in-kernel PCMCIA drivers to be enabled"
		eerror "for kernel 2.6.x."
		eerror
		die "linux-${KV_FULL} without PCMCIA support detected"
	fi
}


src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc4.patch
	epatch ${FILESDIR}/${P}-CS_EVENT_RESET_COMPLETE.patch
	epatch ${FILESDIR}/${P}-ldflags.patch
	epatch ${FILESDIR}/${P}-move-pnp-ids.patch
	epatch ${FILESDIR}/${P}-x11.patch
	epatch ${FILESDIR}/${P}-tools-only.patch

	sed -i -e 's:usr/man:usr/share/man:g' ${S}/Configure
}

pcmcia_cs_configure() {
	# output arguments to Configure to assist in debugging
	echo "${S}/Configure $@"
	${S}/Configure "$@" || die "Configure failed"
	return ${?}
}

src_compile() {
	local config CONFIG_FILE

	if use trusted; then
		ewarn "Unsafe user-space tools enabled"
		config="${config} --trust"
	else
		einfo "Unsafe user-space tools disabled"
		config="${config} --notrust"
	fi

	if linux_chkconfig_present PNP; then
		einfo "Plug and Play support enabled"
		config="${config} --pnp"
	else
		einfo "Plug and Play support disabled"
		config="${config} --nopnp"
	fi

	# cardctl, cardinfo and xcardinfo are setUID
	append-ldflags -Wl,-z,now

	pcmcia_cs_configure \
		--noprompt \
		--kernel=${KV_DIR} \
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

	# config file to be altered
	CONFIG_FILE="${S}/config.mk"

	if use X; then
		echo "HAS_XAW=y" >> ${CONFIG_FILE}

		if use gtk; then
			echo "HAS_GTK=y" >> ${CONFIG_FILE}

			if use gtk2; then
				echo "GTK_CFLAGS=$(pkg-config --cflags gtk+-2.0)" >> ${CONFIG_FILE}
				echo "GTK_LIBS=$(pkg-config --libs gtk+-2.0)" >> ${CONFIG_FILE}
			else
				echo "GTK_CFLAGS=$(gtk-config --cflags)" >> ${CONFIG_FILE}
				echo "GTK_LIBS=$(gtk-config --libs)" >> ${CONFIG_FILE}
			fi
		fi

		if use xforms; then
			echo "FLIBS=-L/usr/X11R6/lib -L/usr/X11/lib -lforms -lX11 -lm -lXpm" >> ${CONFIG_FILE}
			echo "HAS_FORMS=y" >> ${CONFIG_FILE}
		fi
	fi

	emake all || die "emake all failed"
}

src_install () {
	emake install || die "emake install failed"

	# Gentoo specific rc-scripts
	rm -rf ${D}/etc/rc*.d
	newconfd ${FILESDIR}/${P}-conf.d pcmcia
	newinitd ${FILESDIR}/${P}-init.d pcmcia

	if ! use vanilla; then
		# Gentoo specific network script
		exeinto /etc/pcmcia
		newexe ${FILESDIR}/${P}-network network
	fi

	# remove bogus modules.conf file
	rm -f ${D}/etc/modules.conf

	# remove empty directory structure
	rm -rf ${D}/var

	if [[ "${ARCH}" = "ppc" ]]; then
		insinto /etc/pcmcia
		newins ${FILESDIR}/${P}-ppc.config.opts config.opts
	fi

	dodoc BUGS CHANGES MAINTAINERS README README-2.4 \
		SUPPORTED.CARDS doc/*
}
