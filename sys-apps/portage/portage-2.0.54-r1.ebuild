# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.0.54-r1.ebuild,v 1.4 2006/04/22 18:19:26 vapier Exp $

inherit toolchain-funcs eutils

PATCHVER="-1"
DESCRIPTION="The Portage Package Management System. The primary package management and distribution system for Gentoo."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PN}-${PV}.tar.bz2  mirror://gentoo/${PN}-patches-${PV}${PATCHVER}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 m68k ~mips ~ppc ~ppc-macos ~ppc64 s390 sh ~sparc ~x86"

SLOT="0"
IUSE="build doc selinux"
DEPEND=">=dev-lang/python-2.2.1"
RDEPEND="!build? ( >=sys-apps/sed-4.0.5 dev-python/python-fchksum >=dev-lang/python-2.3 userland_GNU? ( sys-apps/debianutils ) >=app-shells/bash-2.05a ) !userland_Darwin? ( >=app-misc/pax-utils-0.1.11 sys-apps/sandbox ) selinux? ( >=dev-python/python-selinux-2.15 ) doc? ( app-portage/portage-manpages )"
PROVIDE="virtual/portage"

S=${WORKDIR}/${PN}-${PV}

portage_docs() {
	einfo ""
	einfo "For help with using portage please consult the Gentoo Handbook"
	einfo "at http://www.gentoo.org/doc/en/handbook/handbook-x86.xml?part=3"
	einfo ""
}

src_unpack() {
	unpack ${A}
	cd ${S}
	for p in "${WORKDIR}"/patch/*.patch ; do
		epatch "${p}"
	done
}

src_compile() {
	python -O -c "import compileall; compileall.compile_dir('${S}/pym')"

	cd "${S}"/src
	$(tc-getCC) ${CFLAGS} -o tbz2tool tbz2tool.c

	if ! use userland_Darwin; then
		cd "${S}"/src/python-missingos
		chmod +x setup.py
		./setup.py build || die "Failed to build missingos module"
	fi

	if use elibc_FreeBSD; then
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

	if ! use userland_Darwin; then
		cd "${S}"/src/python-missingos
		./setup.py install --root ${D} || die "Failed to install missingos module"
	fi

	if use elibc_FreeBSD; then
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

	dodir /usr/bin
	for x in ebuild emerge portageq repoman tbz2tool xpak; do
		dosym ../lib/portage/bin/${x} /usr/bin/${x}
	done

	dodir /usr/sbin
	for x in archive-conf dispatch-conf emaint emerge-webrsync env-update etc-update fixpackages quickpkg regenworld; do
		dosym ../lib/portage/bin/${x} /usr/sbin/${x}
	done

	dodir /etc/portage
	keepdir /etc/portage

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

	if [ ! -f "${ROOT}/var/lib/portage/world" ] &&
	   [ -f ${ROOT}/var/cache/edb/world ] &&
	   [ ! -h ${ROOT}/var/cache/edb/world ]; then
		mv ${ROOT}/var/cache/edb/world ${ROOT}/var/lib/portage/world
		ln -s ../../lib/portage/world /var/cache/edb/world
	fi

	for x in ${ROOT}etc/._cfg????_make.globals; do
		# Overwrite the globals file automatically.
		[ -e "${x}" ] && mv -f "${x}" "${ROOT}etc/make.globals"
	done

	portage_docs
}
