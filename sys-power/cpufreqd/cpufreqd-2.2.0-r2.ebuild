# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufreqd/cpufreqd-2.2.0-r2.ebuild,v 1.1 2006/10/22 08:24:58 phreak Exp $

inherit eutils autotools

NVCLOCK_VERSION="0.8b"

DESCRIPTION="CPU Frequency Daemon"
HOMEPAGE="http://cpufreqd.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
		nvidia? ( http://www.linuxhardware.org/nvclock/nvclock${NVCLOCK_VERSION}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE="acpi apm lm_sensors nforce2 nvidia pmu"
RDEPEND=">=sys-power/cpufrequtils-002
		lm_sensors? ( sys-apps/lm_sensors )"
DEPEND="sys-apps/sed
		${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:acpi_event:acpi:" "${S}"/cpufreqd.conf

	if use nvidia; then
		cd "${WORKDIR}"/nvclock${NVCLOCK_VERSION}
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

	newinitd "${FILESDIR}"/${P}-init.d ${PN}
}

pkg_postinst() {
	if [ -f "${ROOT}"/etc/conf.d/cpufreqd ] ; then
		ewarn "Please make sure, you remove \"/etc/conf.d/cpufreqd\". It breaks"
		ewarn "the init-script! (#152096)"
		ewarn
		ewarn "Use this if you don't know how to do it:"
		ewarn "# rm /etc/conf.d/cpufreqd"
	fi
}
