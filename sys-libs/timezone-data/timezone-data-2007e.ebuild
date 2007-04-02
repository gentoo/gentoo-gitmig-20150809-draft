# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/timezone-data/timezone-data-2007e.ebuild,v 1.1 2007/04/02 20:46:16 vapier Exp $

inherit eutils toolchain-funcs flag-o-matic

code_ver=${PV}
data_ver=${PV}
DESCRIPTION="Timezone data (/usr/share/zoneinfo) and utilities (tzselect/zic/zdump)"
HOMEPAGE="ftp://elsie.nci.nih.gov/pub/"
SRC_URI="ftp://elsie.nci.nih.gov/pub/tzdata${data_ver}.tar.gz
	ftp://elsie.nci.nih.gov/pub/tzcode${code_ver}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="nls"

DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-2005n-makefile.patch
	tc-is-cross-compiler && cp -pR "${S}" "${S}"-native
}

src_compile() {
	tc-export CC
	use elibc_FreeBSD && append-flags -DSTD_INSPIRED #138251
	if use nls ; then
		use elibc_glibc || append-ldflags -lintl #154181
		export NLS=1
	else
		export NLS=0
	fi
	emake || die "emake failed"
	if tc-is-cross-compiler ; then
		make -C "${S}"-native CC=$(tc-getBUILD_CC) zic || die
	fi
}

src_install() {
	local zic=""
	tc-is-cross-compiler && zic="zic=${S}-native/zic"
	make install ${zic} DESTDIR="${D}" || die
	rm -rf "${D}"/usr/share/zoneinfo-leaps
	dodoc README Theory
	dohtml *.htm *.jpg
}

pkg_config() {
	# make sure the /etc/localtime file does not get stale #127899
	local tz=$(unset TIMEZONE ; source "${ROOT}"/etc/conf.d/clock ; echo ${TIMEZONE-FOOKABLOIE})
	[[ -z ${tz} ]] && return 0
	if [[ ${tz} == "FOOKABLOIE" ]] ; then
		elog "You do not have TIMEZONE set in /etc/conf.d/clock."
		if [[ ! -e ${ROOT}/etc/localtime ]] ; then
			cp -f "${ROOT}"/usr/share/zoneinfo/Factory "${ROOT}"/etc/localtime
			elog "Setting /etc/localtime to Factory."
		else
			elog "Skipping auto-update of /etc/localtime."
		fi
		return 0
	fi

	if [[ ! -e ${ROOT}/usr/share/zoneinfo/${tz} ]] ; then
		elog "You have an invalid TIMEZONE setting in /etc/conf.d/clock."
		elog "Your /etc/localtime has been reset to Factory; enjoy!"
		tz="Factory"
	fi
	einfo "Updating /etc/localtime with /usr/share/zoneinfo/${tz}"
	[[ -L ${ROOT}/etc/localtime ]] && rm -f "${ROOT}"/etc/localtime
	cp -f "${ROOT}"/usr/share/zoneinfo/"${tz}" "${ROOT}"/etc/localtime
}

pkg_postinst() {
	pkg_config
}
