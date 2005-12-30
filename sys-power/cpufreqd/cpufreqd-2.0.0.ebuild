# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufreqd/cpufreqd-2.0.0.ebuild,v 1.3 2005/12/30 11:57:21 brix Exp $

inherit eutils

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

NVCLOCK_VERSION="0.8b"

DESCRIPTION="CPU Frequency Daemon"
HOMEPAGE="http://cpufreqd.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
		nvidia? ( http://www.linuxhardware.org/nvclock/nvclock${NVCLOCK_VERSION}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE="acpi apm lm_sensors nforce2 nvidia pmu"
DEPEND="sys-power/cpufrequtils
		lm_sensors? ( sys-apps/lm_sensors )"

src_unpack() {
	unpack ${A}

	if use nvidia; then
		cd ${WORKDIR}/nvclock${NVCLOCK_VERSION}
		epatch ${FILESDIR}/nvclock${NVCLOCK_VERSION}-fd.patch
		epatch ${FILESDIR}/nvclock${NVCLOCK_VERSION}-fpic.patch
	fi
}

src_compile() {
	local config

	if use nvidia; then
		cd ${WORKDIR}/nvclock${NVCLOCK_VERSION}
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

	newinitd ${FILESDIR}/${P}-init.d ${PN}
}

pkg_postinst() {
	einfo
	einfo "Significant changes have happened since the 1.x releases, including"
	einfo "changes in the configuration file format."
	einfo
	einfo "Make sure you update your /etc/cpufreqd.conf file before starting"
	einfo "${PN}. You can use 'etc-update' to accomplish this:"
	einfo
	einfo "  # etc-update"
	einfo
}
