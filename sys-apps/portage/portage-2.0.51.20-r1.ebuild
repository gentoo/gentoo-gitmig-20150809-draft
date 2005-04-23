# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.0.51.20-r1.ebuild,v 1.1 2005/04/23 12:12:44 jstubbs Exp $

inherit toolchain-funcs

DESCRIPTION="The Portage Package Management System. The primary package management and distribution system for Gentoo."
HOMEPAGE="http://www.gentoo.org/"

SRC_URI="mirror://gentoo/${PN}-${PV}.tar.bz2 http://dev.gentoo.org/~jstubbs/releases/${PN}-${PV}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
#KEYWORDS="  alpha  amd64  arm  hppa  ia64  mips  ppc  ppc-macos  ppc64  s390  sh  sparc  x86"
KEYWORDS="  ~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"
RESTRICT="nosandbox sandbox multilib-pkg-force"

# Disable the sandbox on portages that don't support RESTRICT="nosandbox"
export SANDBOX_DISABLED="1"

IUSE="build sandbox selinux"
DEPEND=""
RDEPEND="!build? ( >=sys-apps/sed-4.0.5 dev-python/python-fchksum >=dev-lang/python-2.2.1 sys-apps/debianutils >=app-shells/bash-2.05a ) sandbox? ( sys-apps/sandbox ) selinux? ( >=dev-python/python-selinux-2.15 )"

S=${WORKDIR}/${PN}-${PV}


python_has_lchown() {
	[ "$(python -c 'import os; print "lchown" in dir(os)')" = "True" ]
}

src_unpack() {
	unpack ${A}
	patch -d ${S} -p0 -g0 < ${FILESDIR}/dispatch-conf-fixes.patch
	patch -d ${S} -p0 -g0 < ${FILESDIR}/repoman-fixes.patch
}

src_compile() {
	python -O -c "import compileall; compileall.compile_dir('${S}/pym')"

	export CC="$(tc-getCC)"
	cd ${S}/src
	${CC} ${CFLAGS} -o tbz2tool tbz2tool.c

	if ! python_has_lchown; then
		cd ${S}/src/python-missingos
		./setup.py build || die "Failed to build missingos module"
	fi

	if use x86-fbsd; then
		cd ${S}/src/bsd-flags
		./setup.py build || die "Failed to install bsd-chflags module"
	fi
}

src_install() {
	cd ${S}/cnf
	insinto /etc
	doins etc-update.conf dispatch-conf.conf make.globals
	if [ -f "make.globals.${ARCH}" ]; then
		newins make.conf.${ARCH} make.conf.example
	else
		eerror ""
		eerror "Portage does not have an arch-specific configuration for this arch."
		eerror "Please notify the arch maintainer about this issue. Using generic."
		eerror ""
		newins make.conf make.conf.example
	fi

	if ! python_has_lchown; then
		cd ${S}/src/python-missingos
		./setup.py install --root ${D} || die "Failed to install missingos module"
	fi

	if use x86-fbsd; then
		cd ${S}/src/bsd-flags
		./setup.py install --root ${D} || die "Failed to install bsd-chflags module"
	fi

	dodir /usr/lib/portage/bin
	exeinto /usr/lib/portage/bin
	cd ${S}/bin
	doexe *
	doexe ${S}/src/tbz2tool
	dosym newins /usr/lib/portage/bin/donewins

	dodir /usr/lib/portage/pym
	insinto /usr/lib/portage/pym
	cd ${S}/pym
	doins *

	doman ${S}/man/*.[0-9]
	dodoc ${S}/ChangeLog

	dodir /usr/bin /usr/sbin
	dosym ../lib/portage/bin/emerge /usr/bin/emerge
	dosym ../lib/portage/bin/xpak /usr/bin/xpak
	dosym ../lib/portage/bin/repoman /usr/bin/repoman
	dosym ../lib/portage/bin/tbz2tool /usr/bin/tbz2tool
	dosym ../lib/portage/bin/portageq /usr/bin/portageq
	dosym ../lib/portage/bin/quickpkg /usr/bin/quickpkg
	dosym ../lib/portage/bin/g-cpan.pl /usr/bin/g-cpan.pl

	dosym ../lib/portage/bin/env-update /usr/sbin/env-update
	dosym ../lib/portage/bin/ebuild /usr/sbin/ebuild
	dosym ../lib/portage/bin/etc-update /usr/sbin/etc-update
	dosym ../lib/portage/bin/dispatch-conf /usr/sbin/dispatch-conf
	dosym ../lib/portage/bin/archive-conf /usr/sbin/archive-conf
	dosym ../lib/portage/bin/fixpackages /usr/sbin/fixpackages
	dosym ../lib/portage/bin/regenworld /usr/sbin/regenworld
	dosym ../lib/portage/bin/emerge-webrsync /usr/sbin/emerge-webrsync
}

pkg_preinst() {
	if has livecvsportage ${FEATURES} && [ "${ROOT}" = "/" ]; then
		rm -rf ${IMAGE}/usr/lib/portage/pym/*
		mv ${IMAGE}/usr/lib/portage/bin/tbz2tool ${T}
		rm -rf ${IMAGE}/usr/lib/portage/bin/*
		mv ${T}/tbz2tool ${IMAGE}/usr/lib/portage/bin/
	fi
}

pkg_postinst() {
	local x

	[ -f "${ROOT}etc/make.conf" ] || touch ${ROOT}etc/make.conf

	#disable global sandbox if it's active (it's been deprecated)
	if [ -f /etc/ld.so.preload ] ; then
		cp /etc/ld.so.preload ${T}
		grep -v libsandbox ${T}/ld.so.preload > /etc/ld.so.preload
	fi

	#yank old cache files
	if [ -d /var/cache/edb ]
	then
		rm -f /var/cache/edb/xcache.p
		rm -f /var/cache/edb/mtimes
	fi

	install -o root -g portage -m 0755 -d "${ROOT}/etc/portage"

	if [ ! -f "${ROOT}/var/lib/portage/world" ] &&
	   [ -f ${ROOT}/var/cache/edb/world ] &&
	   [ ! -h ${ROOT}/var/cache/edb/world ]; then
		mv ${ROOT}/var/cache/edb/world ${ROOT}/var/lib/portage/world
		ln -s ../../lib/portage/world /var/cache/edb/world
	fi

	echo
	einfo "Feature additions are noted in help and make.conf descriptions."
	echo
	einfo "Update configs using 'etc-update' please. Maintaining current configs"
	einfo "for portage and other system packages is fairly important for the"
	einfo "continued health of your system."
	echo
	ewarn "NOTICE: There have been changes in the location of some internal files"
	ewarn "        to better match the FHS. The changes do not directly affect users"
	ewarn "        but please be advised that changing between versions of portage"
	ewarn "        with and without these changes may introduce some inconsistencies"
	ewarn "        in package data regarding 'world' and 'virtuals' (provides)."
	echo
	einfo "        /var/cache/edb/world has moved to /var/lib/portage/world"
	echo
	einfo "        /var/cache/edb/virtuals has been deprecated and is now calculated"
	einfo "        on demand. Strictly _USER_ modifications to virtuals may go into"
	einfo "        /etc/portage/profile/virtuals and will not be modified by portage."
	echo

	for X in ${ROOT}etc/._cfg????_make.globals; do
		# Overwrite the globals file automatically.
		[ -e "${X}" ] && mv -f "${X}" "${ROOT}etc/make.globals"
	done

	einfo "You may run 'emerge metadata' to perform cache updates if you have"
	einfo "changed versions of portage. This will provide a fairly dramatic"
	einfo "speedup. Alternatively, you may 'emerge sync' if it has been more"
	einfo "than 30 minutes since your last sync."
}
