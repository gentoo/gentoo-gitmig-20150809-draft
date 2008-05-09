# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.1.5_rc9.ebuild,v 1.1 2008/05/09 20:30:51 zmedico Exp $

inherit toolchain-funcs eutils flag-o-matic multilib

DESCRIPTION="Portage is the package management and distribution system for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/index.xml"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
PROVIDE="virtual/portage"
SLOT="0"
IUSE="build doc epydoc selinux linguas_pl"
DEPEND=">=dev-lang/python-2.4
	!build? ( >=sys-apps/sed-4.0.5 )
	doc? ( app-text/xmlto ~app-text/docbook-xml-dtd-4.4 )
	epydoc? ( >=dev-python/epydoc-2.0 )"
RDEPEND=">=dev-lang/python-2.4
	!build? ( >=sys-apps/sed-4.0.5
		>=app-shells/bash-3.2_p17 )
	elibc_FreeBSD? ( sys-freebsd/freebsd-bin )
	elibc_glibc? ( >=sys-apps/sandbox-1.2.17 !mips? ( >=sys-apps/sandbox-1.2.18.1-r2 ) )
	elibc_uclibc? ( >=sys-apps/sandbox-1.2.17 !mips? ( >=sys-apps/sandbox-1.2.18.1-r2 ) )
	>=app-misc/pax-utils-0.1.13
	selinux? ( >=dev-python/python-selinux-2.16 )"
PDEPEND="
	doc? (
		|| ( app-portage/eclass-manpages app-portage/portage-manpages )
	)
	!build? (
		>=net-misc/rsync-2.6.4
		userland_GNU? ( >=sys-apps/coreutils-6.4 )
		|| ( >=dev-lang/python-2.5 >=dev-python/pycrypto-2.0.1-r6 )
	)"
# coreutils-6.4 rdep is for date format in emerge-webrsync #164532
# rsync-2.6.4 rdep is for the --filter option #167668
SRC_ARCHIVES="http://dev.gentoo.org/~zmedico/portage/archives"

PV_PL="2.1.2"
PATCHVER_PL=""
TARBALL_PV="2.1.4"
SRC_URI="mirror://gentoo/${PN}-${TARBALL_PV}.tar.bz2
	${SRC_ARCHIVES}/${PN}-${TARBALL_PV}.tar.bz2
	linguas_pl? ( mirror://gentoo/${PN}-man-pl-${PV_PL}.tar.bz2
	${SRC_ARCHIVES}/${PN}-man-pl-${PV_PL}.tar.bz2 )"

PATCHVER="${PV}"
if [ -n "${PATCHVER}" ]; then
	SRC_URI="${SRC_URI} mirror://gentoo/${PN}-${PATCHVER}.patch.bz2
	${SRC_ARCHIVES}/${PN}-${PATCHVER}.patch.bz2"
fi

if [ -n "${PATCHVER_PL}" ]; then
	SRC_URI="${SRC_URI} linguas_pl? ( mirror://gentoo/${PN}-man-pl-${PV_PL}${PATCHVER_PL}.patch.bz2
	${SRC_ARCHIVES}/${PN}-man-pl-${PV_PL}${PATCHVER_PL}.patch.bz2 )"
fi

S="${WORKDIR}"/${PN}-${TARBALL_PV}
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
	if [ -n "${PATCHVER}" ]; then
		cd "${S}"
		epatch "${WORKDIR}/${PN}-${PATCHVER}.patch"
	fi
	einfo "Setting portage.VERSION to ${PVR} ..."
	sed -i "s/^VERSION=.*/VERSION=\"${PVR}\"/" pym/portage.py || \
		die "Failed to patch portage.VERSION"
	eend 0
	if [ -n "${PATCHVER_PL}" ]; then
		use linguas_pl && \
			epatch "${WORKDIR}/${PN}-man-pl-${PV_PL}${PATCHVER_PL}.patch"
	fi
}

src_compile() {
	append-lfs-flags

	cd "${S}"/src
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o tbz2tool tbz2tool.c || \
		die "Failed to build tbz2tool"

	if use doc; then
		cd "${S}"/doc
		touch fragment/date
		sed -i "s/svn-trunk/${PVR}/" fragment/version
		make xhtml xhtml-nochunks || die "failed to make docs"
	fi

	if use epydoc; then
		einfo "Generating api docs"
		mkdir "${WORKDIR}"/api
		local my_modules
		my_modules="$(find "${S}/pym" -name "*.py" \
			| sed -e 's:/__init__.py$::' -e 's:\.py$::' -e "s:^${S}/pym/::" \
			 -e 's:/:.:g')" || die "error listing modules"
		PYTHONPATH="${S}/pym:${PYTHONPATH}" epydoc -o "${WORKDIR}"/api \
			-qqqqq --no-frames --show-imports \
			--name "${PN}" --url "${HOMEPAGE}" \
			${my_modules} || die "epydoc failed"
	fi
}

src_test() {
	./tests/runTests || \
		die "test(s) failed"
}

src_install() {
	local libdir=$(get_libdir)
	local portage_base="/usr/${libdir}/portage"
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

	insinto /etc/logrotate.d
	doins "${S}"/cnf/logrotate.d/elog-save-summary

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

	local mydir
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
	use doc && dohtml "${S}"/doc/*.html
	use epydoc && dohtml -r "${WORKDIR}"/api

	dodir /usr/bin
	local x
	for x in ebuild emerge portageq repoman tbz2tool xpak; do
		dosym ../${libdir}/portage/bin/${x} /usr/bin/${x}
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
		dosym ../${libdir}/portage/bin/${x} /usr/sbin/${x}
	done
	dosym env-update /usr/sbin/update-env
	dosym etc-update /usr/sbin/update-etc

	dodir /etc/portage
	keepdir /etc/portage

	echo PYTHONPATH=\"${portage_base}/pym\" > "${WORKDIR}"/05portage.envd
	doenvd "${WORKDIR}"/05portage.envd
}

pkg_preinst() {
	if ! use build && ! has_version dev-python/pycrypto && \
		has_version '>=dev-lang/python-2.5' ; then
		if ! built_with_use '>=dev-lang/python-2.5' ssl ; then
			echo "If you are a Gentoo developer and you plan to" \
			"commit ebuilds with this system then please install" \
			"pycrypto or enable python's ssl USE flag in order" \
			"to enable RMD160 hash support. See bug #198398 for" \
			"more information." | \
			fmt -w 70 | while read line ; do ewarn "${line}" ; done
		fi
	fi
	local portage_base="/usr/$(get_libdir)/portage"
	if has livecvsportage ${FEATURES} && [ "${ROOT}" = "/" ]; then
		rm -rf "${D}"/${portage_base}/pym/*
		mv "${D}"/${portage_base}/bin/tbz2tool "${T}"
		rm -rf "${D}"/${portage_base}/bin/*
		mv "${T}"/tbz2tool "${D}"/${portage_base}/bin/
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

	# Compile all source files recursively. Any orphans
	# will be identified and removed in postrm.
	compile_all_python_bytecodes "${ROOT}usr/$(get_libdir)/portage/pym"

	echo "The metadata-transfer feature is now disabled" \
		"by default. This disables the \"Updating Portage cache\"" \
		"routine that used to run at the tail end of each" \
		"\`emerge --sync\` operation. If you use something" \
		"like the sqlite module and want to keep all metadata" \
		"in that format alone (useful for querying), enable" \
		"FEATURES=\"metadata-transfer\" in make.conf." \
		| fmt -w 75 | while read x ; do elog "$x" ; done

	portage_docs
}

pkg_postrm() {
	remove_orphan_python_bytecodes "${ROOT}usr/$(get_libdir)/portage/pym"
}

compile_all_python_bytecodes() {
	python -c "from compileall import compile_dir; compile_dir('${1}', quiet=True)"
	python -O -c "from compileall import compile_dir; compile_dir('${1}', quiet=True)"
}

remove_orphan_python_bytecodes() {
	[[ -d ${1} ]] || return
	find "${1}" -name '*.py[co]' -print0 | \
	while read -d $'\0' f ; do
		src_py=${f%[co]}
		[[ -f ${src_py} ]] && continue
		rm -f "${src_py}"[co]
	done
}
