# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.1-r2.ebuild,v 1.8 2006/08/11 13:21:27 wolf31o2 Exp $

inherit toolchain-funcs eutils

DESCRIPTION="The Portage Package Management System. The primary package management and distribution system for Gentoo."
HOMEPAGE="http://www.gentoo.org/proj/en/portage/index.xml"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc-macos ~ppc64 s390 sh sparc x86 ~x86-fbsd"
PROVIDE="virtual/portage"
SLOT="0"
# USE_EXPAND_HIDDEN hides ELIBC and USERLAND expansions from emerge output (see make.conf.5).
IUSE_ELIBC="elibc_glibc elibc_uclibc elibc_FreeBSD"
IUSE_USERLAND="userland_Darwin userland_GNU"
IUSE="build doc selinux linguas_pl ${IUSE_ELIBC} ${IUSE_USERLAND}"
DEPEND=">=dev-lang/python-2.3
	!build? ( >=sys-apps/sed-4.0.5 )"
RDEPEND=">=dev-lang/python-2.3
	!build? ( >=sys-apps/sed-4.0.5
		dev-python/python-fchksum
		!userland_Darwin? ( >=app-shells/bash-3.0 ) )
	elibc_glibc? ( sys-apps/sandbox )
	elibc_uclibc? ( sys-apps/sandbox )
	!userland_Darwin? ( >=app-misc/pax-utils-0.1.13 )
	selinux? ( >=dev-python/python-selinux-2.16 )
	doc? ( app-portage/portage-manpages )
	>=dev-python/pycrypto-2.0.1-r5"
SRC_ARCHIVES="http://dev.gentoo.org/~zmedico/portage/archives"
PV_PL="2.1"
PATCHVER_PL="-r1"
SRC_URI="mirror://gentoo/${PF}.tar.bz2
	${SRC_ARCHIVES}/${PF}.tar.bz2
	linguas_pl? ( mirror://gentoo/${PN}-man-pl-${PV_PL}.tar.bz2
	${SRC_ARCHIVES}/${PN}-man-pl-${PV_PL}.tar.bz2 )"

if [ -n "${PATCHVER_PL}" ]; then
	SRC_URI="${SRC_URI} linguas_pl? ( mirror://gentoo/${PN}-man-pl-${PV_PL}${PATCHVER_PL}.patch.bz2
	${SRC_ARCHIVES}/${PN}-man-pl-${PV_PL}${PATCHVER_PL}.patch.bz2 )"
fi

S="${WORKDIR}"/${PF}
S_PL="${WORKDIR}"/${PN}-${PV_PL}

portage_docs() {
	elog ""
	elog "For help with using portage please consult the Gentoo Handbook"
	elog "at http://www.gentoo.org/doc/en/handbook/handbook-x86.xml?part=3"
	elog ""
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	use linguas_pl && \
		epatch "${WORKDIR}/${PN}-man-pl-${PV_PL}${PATCHVER_PL}.patch"
}

src_compile() {
	cd "${S}"/src
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o tbz2tool tbz2tool.c || \
		die "Failed to build tbz2tool"

	if use elibc_FreeBSD; then
		cd "${S}"/src/bsd-flags
		chmod +x setup.py
		./setup.py build || die "Failed to install bsd-chflags module"
	fi
}

src_install() {
	local portage_base="/usr/lib/portage"
	cd "${S}"/cnf
	insinto /etc
	doins etc-update.conf dispatch-conf.conf make.globals
	if [ -f "make.conf.${ARCH}".diff ]; then
		patch make.conf "make.conf.${ARCH}".diff || \
			die "Failed to patch make.conf.example"
		newins make.conf make.conf.example
	else
		eerror ""
		eerror "Portage does not have an arch-specific configuration for this arch."
		eerror "Please notify the arch maintainer about this issue. Using generic."
		eerror ""
		newins make.conf make.conf.example
	fi

	if use elibc_FreeBSD; then
		cd "${S}"/src/bsd-flags
		./setup.py install --root "${D}" || \
			die "Failed to install bsd-chflags module"
	fi

	dodir ${portage_base}/bin
	exeinto ${portage_base}/bin
	# BSD and OSX need a sed wrapper so that find/xargs work properly
	if use userland_GNU; then
		rm "${S}"/bin/sed || die "Failed to remove sed wrapper"
	fi
	cd "${S}"/bin
	doexe *
	doexe "${S}"/src/tbz2tool
	dosym newins ${portage_base}/bin/donewins

	for mydir in pym pym/cache pym/elog_modules; do
		dodir ${portage_base}/${mydir}
		insinto ${portage_base}/${mydir}
		cd "${S}"/${mydir}
		doins *.py
	done

	doman "${S}"/man/*.[0-9]
	if use linguas_pl; then
		doman -i18n=pl "${S_PL}"/man/pl/*.[0-9]
		doman -i18n=pl_PL.UTF-8 "${S_PL}"/man/pl_PL.UTF-8/*.[0-9]
	fi
	dodoc "${S}"/ChangeLog
	dodoc "${S}"/NEWS
	dodoc "${S}"/RELEASE-NOTES

	dodir /usr/bin
	for x in ebuild emerge portageq repoman tbz2tool xpak; do
		dosym ../lib/portage/bin/${x} /usr/bin/${x}
	done

	dodir /usr/sbin
	local my_syms="archive-conf
		dispatch-conf
		emaint
		emerge-webrsync
		env-update
		etc-update
		fixpackages
		quickpkg
		regenworld"
	local x
	for x in ${my_syms}; do
		dosym ../lib/portage/bin/${x} /usr/sbin/${x}
	done

	dodir /etc/portage
	keepdir /etc/portage

	doenvd "${FILESDIR}"/05portage.envd
}

pkg_preinst() {
	local portage_base="/usr/lib/portage"
	if has livecvsportage ${FEATURES} && [ "${ROOT}" = "/" ]; then
		rm -rf "${IMAGE}"/${portage_base}/pym/*
		mv "${IMAGE}"/${portage_base}/bin/tbz2tool "${T}"
		rm -rf "${IMAGE}"/${portage_base}/bin/*
		mv "${T}"/tbz2tool "${IMAGE}"/${portage_base}/bin/
	else
		for mydir in pym pym/cache pym/elog_modules; do
			rm "${ROOT}"/${portage_base}/${mydir}/*.pyc >& /dev/null
			rm "${ROOT}"/${portage_base}/${mydir}/*.pyo >& /dev/null
		done
	fi
}

pkg_postinst() {
	local x

	if [ ! -f "${ROOT}/var/lib/portage/world" ] &&
	   [ -f "${ROOT}"/var/cache/edb/world ] &&
	   [ ! -h "${ROOT}"/var/cache/edb/world ]; then
		mv "${ROOT}"/var/cache/edb/world "${ROOT}"/var/lib/portage/world
		ln -s ../../lib/portage/world /var/cache/edb/world
	fi

	for x in "${ROOT}"/etc/._cfg????_make.globals; do
		# Overwrite the globals file automatically.
		[ -e "${x}" ] && mv -f "${x}" "${ROOT}etc/make.globals"
	done

	ewarn "Portage 2.1 contains a completely rewritten caching framework."
	ewarn "If you are using any cache modules from portage-2.0.x (such as"
	ewarn "the CDB cache module), portage will not work until they have"
	ewarn "been disabled via /etc/portage/modules."
	echo
	elog "The default cache format has changed between 2.0.x and 2.1"
	elog "versions. If you have upgraded from 2.0.x, before using"
	elog "emerge, run \`emerge --metadata\` to restore portage's local"
	elog "cache."
	echo
	elog "With the new metadata_overlay cache module, it is possible to"
	elog "disable FEATURES=\"metadata-transfer\" (see make.conf.5)."
	elog "When this module is used, eclasses in \${PORTDIR} must never"
	elog "be modified by the user because portage will not be able to"
	elog "detect that cache regeneration is necessary."
	elog "When metadata_overlay is initially enabled by setting"
	elog "portdbapi.auxdbmodule = cache.metadata_overlay.database"
	elog "in /etc/portage/modules, the user must completely remove"
	elog "/var/cache/edb/dep/\${PORTDIR} in order to avoid unecessary"
	elog "cache regeneration."
	echo
	elog "Flag ordering has changed for \`emerge --pretend --verbose\`."
	elog "Add EMERGE_DEFAULT_OPTS=\"--alphabetical\" to /etc/make.conf"
	elog "to restore the previous ordering."
	echo
	elog "The default USE_ORDER setting (see make.conf.5) has changed in"
	elog "2.1 so that auto USE flags (from use.defaults) are no longer"
	elog "enabled.  In order to find out which flags have been disabled,"
	elog "the command \`env USE_ORDER=auto portageq envvar USE\` may be"
	elog "helpful.  These flags can be manually added to make.conf by the"
	elog "user (the command output may contain a few other automatically"
	elog "generated flags that do not need to be added to make.conf)."
	echo
	elog "See NEWS and RELEASE-NOTES for further changes."

	portage_docs
}
