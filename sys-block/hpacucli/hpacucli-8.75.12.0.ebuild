# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/hpacucli/hpacucli-8.75.12.0.ebuild,v 1.1 2011/07/02 17:10:18 idl0r Exp $

EAPI="4"

inherit rpm versionator pax-utils

MY_PV=$(replace_version_separator 2 '-')

SRC_URI_BASE="ftp://ftp.hp.com/pub/softlib2/software1/pubsw-linux"

DESCRIPTION="HP Array Configuration Utility Command Line Interface (HPACUCLI, formerly CPQACUXE)"
HOMEPAGE="http://h18000.www1.hp.com/products/servers/linux/documentation.html"
SRC_URI="${SRC_URI_BASE}/p414707558/v65771/${PN}-${MY_PV}.noarch.rpm"

LICENSE="hp-proliant-essentials"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hardened"

DEPEND=""
RDEPEND="sys-apps/coreutils
	sys-process/procps
	x86? ( sys-libs/lib-compat )
	amd64? ( app-emulation/emul-linux-x86-compat )"

S="${WORKDIR}"

HPACUCLI_BASEDIR="/opt/hp/hpacucli"
HPACUCLI_LOCKDIR="/var/lock/hpacucli"

QA_PRESTRIPPED="/opt/hp/hpacucli/hpacucli.bin"
QA_EXECSTACK="opt/hp/hpacucli/libcpqimgr.so
	opt/hp/hpacucli/hpacucli.bin"

src_install() {
	local MY_S="${S}/opt/compaq/${PN}/bld"

	dosbin "${FILESDIR}"/${PN} || die

	exeinto "${HPACUCLI_BASEDIR}"
	newexe "${MY_S}"/.${PN} ${PN}.bin || die

	insinto "${HPACUCLI_BASEDIR}"
	doins "${MY_S}"/*.so || die

	dodoc "${MY_S}/${PN}-${MY_PV}.noarch.txt"
	doman "${S}"/usr/man/man?/*

	diropts -m0700
	dodir ${HPACUCLI_LOCKDIR}
	cat <<-EOF >"${T}"/45${PN}
		PATH=${HPACUCLI_BASEDIR}
		ROOTPATH=${HPACUCLI_BASEDIR}
		LDPATH=${HPACUCLI_BASEDIR}
		EOF
	doenvd "${T}"/45${PN}

	if use hardened; then
		pax-mark m "${D}/opt/hp/hpacucli/hpacucli.bin"
	fi
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ] ; then
		PATH="${PATH}:/sbin" ldconfig -n "${HPACUCLI_BASEDIR}"
	fi
	einfo
	einfo "For more information regarding this utility, please read"
	einfo "/usr/share/doc/${P}/${PN}-${MY_PV}.noarch.txt"
	einfo
}
