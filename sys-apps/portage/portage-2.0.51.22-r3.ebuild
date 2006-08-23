# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.0.51.22-r3.ebuild,v 1.7 2006/08/23 17:55:13 zmedico Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="The Portage Package Management System. The primary package management and distribution system for Gentoo."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PN}-${PV}.tar.bz2 http://dev.gentoo.org/~jstubbs/releases/${PN}-${PV}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc-macos ppc64 s390 sh sparc x86"

SLOT="0"
IUSE="build doc selinux"
DEPEND=">=dev-lang/python-2.2.1"
RDEPEND="!build? ( >=sys-apps/sed-4.0.5 dev-python/python-fchksum >=dev-lang/python-2.2.1 sys-apps/debianutils >=app-shells/bash-2.05a ) !x86-fbsd? ( !ppc-macos? ( !mips? ( sys-apps/sandbox ) ) ) selinux? ( >=dev-python/python-selinux-2.15 )"
PDEPEND="doc? ( app-portage/portage-manpages )"
PROVIDE="virtual/portage"

S=${WORKDIR}/${PN}-${PV}

python_has_lchown() {
	[ "$(python -c 'import os; print "lchown" in dir(os)')" = "True" ]
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	patch -p1 < ${FILESDIR}/2.0.51.22-fixes.patch
}

src_compile() {
	append-lfs-flags

	cd "${S}"/src
	$(tc-getCC) ${CFLAGS} -o tbz2tool tbz2tool.c

	if ! use ppc-macos && ! python_has_lchown; then
		cd "${S}"/src/python-missingos
		chmod +x setup.py
		./setup.py build || die "Failed to build missingos module"
	fi

	if use x86-fbsd; then
		cd "${S}"/src/bsd-flags
		chmod +x setup.py
		./setup.py build || die "Failed to install bsd-chflags module"
	fi
}

src_install() {
	cd "${S}"/cnf
	insinto /etc
	doins etc-update.conf dispatch-conf.conf make.globals
	if [ -f "make.conf.${ARCH}" ]; then
		newins make.conf.${ARCH} make.conf.example
	else
		eerror ""
		eerror "Portage does not have an arch-specific configuration for this arch."
		eerror "Please notify the arch maintainer about this issue. Using generic."
		eerror ""
		newins make.conf make.conf.example
	fi

	if ! use ppc-macos && ! python_has_lchown; then
		cd "${S}"/src/python-missingos
		./setup.py install --root ${D} || die "Failed to install missingos module"
	fi

	if use x86-fbsd; then
		cd "${S}"/src/bsd-flags
		./setup.py install --root ${D} || die "Failed to install bsd-chflags module"
	fi

	dodir /usr/lib/portage/bin
	exeinto /usr/lib/portage/bin
	cd "${S}"/bin
	doexe *
	doexe "${S}"/src/tbz2tool
	dosym newins /usr/lib/portage/bin/donewins

	dodir /usr/lib/portage/pym
	insinto /usr/lib/portage/pym
	cd "${S}"/pym
	doins *

	doman "${S}"/man/*.[0-9]
	dodoc "${S}"/ChangeLog

	dodir /usr/bin /usr/sbin
	dosym ../lib/portage/bin/emerge /usr/bin/emerge
	dosym ../lib/portage/bin/xpak /usr/bin/xpak
	dosym ../lib/portage/bin/repoman /usr/bin/repoman
	dosym ../lib/portage/bin/tbz2tool /usr/bin/tbz2tool
	dosym ../lib/portage/bin/portageq /usr/bin/portageq
	dosym ../lib/portage/bin/ebuild /usr/bin/ebuild

	dosym ../lib/portage/bin/env-update /usr/sbin/env-update
	dosym ../lib/portage/bin/ebuild /usr/sbin/ebuild
	dosym ../lib/portage/bin/etc-update /usr/sbin/etc-update
	dosym ../lib/portage/bin/dispatch-conf /usr/sbin/dispatch-conf
	dosym ../lib/portage/bin/archive-conf /usr/sbin/archive-conf
	dosym ../lib/portage/bin/quickpkg /usr/sbin/quickpkg
	dosym ../lib/portage/bin/fixpackages /usr/sbin/fixpackages
	dosym ../lib/portage/bin/regenworld /usr/sbin/regenworld
	dosym ../lib/portage/bin/emerge-webrsync /usr/sbin/emerge-webrsync

	doenvd ${FILESDIR}/05portage.envd
}

pkg_preinst() {
	if has livecvsportage ${FEATURES} && [ "${ROOT}" = "/" ]; then
		rm -rf ${IMAGE}/usr/lib/portage/pym/*
		mv ${IMAGE}/usr/lib/portage/bin/tbz2tool ${T}
		rm -rf ${IMAGE}/usr/lib/portage/bin/*
		mv ${T}/tbz2tool ${IMAGE}/usr/lib/portage/bin/
	else
		rm /usr/lib/portage/pym/*.pyc >& /dev/null
		rm /usr/lib/portage/pym/*.pyo >& /dev/null
	fi
}

pkg_postinst() {
	local x

	[ -f "${ROOT}etc/make.conf" ] || touch ${ROOT}etc/make.conf

	install -o root -g portage -m 0755 -d "${ROOT}/etc/portage"

	if [ ! -f "${ROOT}/var/lib/portage/world" ] &&
	   [ -f ${ROOT}/var/cache/edb/world ] &&
	   [ ! -h ${ROOT}/var/cache/edb/world ]; then
		mv ${ROOT}/var/cache/edb/world ${ROOT}/var/lib/portage/world
		ln -s ../../lib/portage/world /var/cache/edb/world
	fi

	echo
	elog "Feature additions are noted in help and make.conf descriptions."
	echo
	elog "Update configs using 'etc-update' please. Maintaining current configs"
	elog "for portage and other system packages is fairly important for the"
	elog "continued health of your system."
	echo
	ewarn "NOTICE: There have been changes in the location of some internal files"
	ewarn "        to better match the FHS. The changes do not directly affect users"
	ewarn "        but please be advised that changing between versions of portage"
	ewarn "        with and without these changes may introduce some inconsistencies"
	ewarn "        in package data regarding 'world' and 'virtuals' (provides)."
	echo
	elog "        /var/cache/edb/world has moved to /var/lib/portage/world"
	echo
	elog "        /var/cache/edb/virtuals has been deprecated and is now calculated"
	elog "        on demand. Strictly _USER_ modifications to virtuals may go into"
	elog "        /etc/portage/profile/virtuals and will not be modified by portage."
	echo

	for X in ${ROOT}etc/._cfg????_make.globals; do
		# Overwrite the globals file automatically.
		[ -e "${X}" ] && mv -f "${X}" "${ROOT}etc/make.globals"
	done

	elog "You may run 'emerge metadata' to perform cache updates if you have"
	elog "changed versions of portage. This will provide a fairly dramatic"
	elog "speedup. Alternatively, you may 'emerge sync' if it has been more"
	elog "than 30 minutes since your last sync."
}
