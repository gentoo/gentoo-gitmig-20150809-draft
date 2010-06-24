# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufreqd/cpufreqd-2.1.1.ebuild,v 1.9 2010/06/24 22:01:18 ssuominen Exp $

inherit eutils

NVCLOCK_VERSION="0.8b"

DESCRIPTION="CPU Frequency Daemon"
HOMEPAGE="http://cpufreqd.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
		nvidia? ( http://www.linuxhardware.org/nvclock/nvclock${NVCLOCK_VERSION}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc"

IUSE="acpi apm lm_sensors nforce2 nvidia pmu"
RDEPEND=">=sys-power/cpufrequtils-002
		lm_sensors? ( <sys-apps/lm_sensors-3 )"
DEPEND="sys-apps/sed
		${RDEPEND}"

src_unpack() {
	unpack ${A}

	sed -i -e "s:acpi_event:acpi:" "${S}"/cpufreqd.conf

	if use nvidia; then
		cd "${WORKDIR}"/nvclock${NVCLOCK_VERSION}
		epatch "${FILESDIR}"/nvclock${NVCLOCK_VERSION}-fd.patch
		epatch "${FILESDIR}"/nvclock${NVCLOCK_VERSION}-fpic.patch
	fi
}

src_compile() {
	local config

	if use nvidia; then
		cd "${WORKDIR}"/nvclock${NVCLOCK_VERSION}
		econf \
			--disable-gtk \
			--disable-qt \
			--disable-nvcontrol \
			|| die "econf nvclock failed"
		emake -j1 || die "emake nvclock failed"
		config="--enable-nvclock=${WORKDIR}/nvclock${NVCLOCK_VERSION}"
	fi

	cd "${S}"
	econf \
		$(use_enable acpi) \
		$(use_enable apm) \
		$(use_enable lm_sensors sensors) \
		$(use_enable nforce2) \
		$(use_enable pmu) \
		${config} \
		|| die "econf failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO

	newinitd "${FILESDIR}"/${PN}-init.d ${PN}
}
