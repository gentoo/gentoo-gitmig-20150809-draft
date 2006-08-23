# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libutempter/libutempter-1.1.2.1.ebuild,v 1.14 2006/08/23 15:52:02 carlo Exp $

inherit rpm eutils flag-o-matic versionator toolchain-funcs

MY_P=${PN}-$(replace_version_separator 3 '-alt')
S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)
PATCHVER="1"
DESCRIPTION="Library that allows non-privileged apps to write utmp (login) info, which need root access"
HOMEPAGE="http://altlinux.org/index.php?module=sisyphus&package=libutempter"
SRC_URI="ftp://ftp.altlinux.ru/pub/distributions/ALTLinux/Sisyphus/SRPMS.classic/${MY_P}.src.rpm
	mirror://gentoo/${PN}-patches-${PATCHVER}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="!sys-apps/utempter"

PROVIDE="virtual/utempter"

PATCHDIR="${WORKDIR}/gentoo/patches"

pkg_setup() {
	enewgroup utmp 406
}

src_unpack() {
	unpack ${A}
	rpm_src_unpack
	cd "${S}"

	export EPATCH_SUFFIX="patch"
	epatch ${PATCHDIR}

	if [[ ${CHOST} == *-freebsd* ]] ; then
		epatch ${PATCHDIR}/freebsd
	fi
}

src_compile() {
	make \
		CC="$(tc-getCC)" \
		RPM_OPT_FLAGS="${CFLAGS}" \
		libdir=/usr/$(get_libdir) \
		libexecdir=/usr/$(get_libdir) || die
}

src_install() {
	make \
		DESTDIR="${D}" \
		libdir=/usr/$(get_libdir) \
		libexecdir=/usr/$(get_libdir) \
		includedir=/usr/include \
		install || die

	fowners root:utmp /usr/$(get_libdir)/utempter/utempter
	fperms 2755 /usr/$(get_libdir)/utempter/utempter
	dodir /usr/sbin
	dosym ../$(get_libdir)/utempter/utempter /usr/sbin/utempter
}


pkg_postinst() {
	if [ -f "${ROOT}/var/log/wtmp" ]
	then
		chown root:utmp "${ROOT}/var/log/wtmp"
		chmod 664 "${ROOT}/var/log/wtmp"
	fi

	if [ -f "${ROOT}/var/run/utmp" ]
	then
		chown root:utmp "${ROOT}/var/run/utmp"
		chmod 664 "${ROOT}/var/run/utmp"
	fi
}
