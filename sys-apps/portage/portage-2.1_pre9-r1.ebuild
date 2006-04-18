# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.1_pre9-r1.ebuild,v 1.1 2006/04/18 10:34:17 zmedico Exp $

inherit toolchain-funcs

DESCRIPTION="The Portage Package Management System. The primary package management and distribution system for Gentoo."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PN}-${PV}.tar.bz2 http://dev.gentoo.org/~zmedico/portage/archives/${PN}-${PV}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

SLOT="0"
IUSE="build doc selinux"
DEPEND=">=dev-lang/python-2.3"
RDEPEND="!build? ( >=sys-apps/sed-4.0.5 \
					dev-python/python-fchksum \
					>=dev-lang/python-2.3 \
					userland_GNU? ( sys-apps/debianutils ) \
					>=app-shells/bash-2.05a ) \
		elibc_glibc? ( sys-apps/sandbox )
		elibc_uclibc? ( sys-apps/sandbox )
		!userland_Darwin? ( >=app-misc/pax-utils-0.1.10 )
		selinux? ( >=dev-python/python-selinux-2.15 ) \
		doc? ( app-portage/portage-manpages )
		>=dev-python/pycrypto-2.0.1-r4"

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
	cd "${S}"
	local my_patches="1000_r3171_readDigests.patch
		1010_r3173_bug_57445_gpgsign.patch"
	local patches_dir="${PV%_*}/${PV/*_}"
	for patch_name in ${my_patches}; do
		einfo "Applying ${patch_name} ..."
		patch -p0 --no-backup-if-mismatch < \
			"${FILESDIR}"/${patches_dir}/${patch_name} >/dev/null || \
			die "Failed to apply patch"
	done
	if [ "${PR}" != "r0" ]; then
		einfo "Setting portage.VERSION to ${PVR} ..."
		sed -i "s/^VERSION=.*/VERSION=\"${PVR}\"/" pym/portage.py || \
			die "Failed to patch portage.VERSION"
	fi
}

src_compile() {
	python -O -c "import compileall; compileall.compile_dir('${S}/pym')"

	cd "${S}"/src
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o tbz2tool tbz2tool.c || \
		die "Failed to build tbz2tool"

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

	if ! use userland_Darwin; then
		cd "${S}"/src/python-missingos
		./setup.py install --root ${D} || \
			die "Failed to install missingos module"
	fi

	if use elibc_FreeBSD; then
		cd "${S}"/src/bsd-flags
		./setup.py install --root ${D} || \
			die "Failed to install bsd-chflags module"
	fi

	dodir /usr/lib/portage/bin
	exeinto /usr/lib/portage/bin
	cd "${S}"/bin
	doexe *
	doexe "${S}"/src/tbz2tool
	dosym newins /usr/lib/portage/bin/donewins

	for mydir in pym pym/cache pym/elog_modules; do
		dodir /usr/lib/portage/${mydir}
		insinto /usr/lib/portage/${mydir}
		cd "${S}"/${mydir}
		doins *.py *.pyo
	done

	doman "${S}"/man/*.[0-9]
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
	for x in ${my_syms}; do
		dosym ../lib/portage/bin/${x} /usr/sbin/${x}
	done

	dodir /etc/portage
	keepdir /etc/portage

	doenvd "${FILESDIR}"/05portage.envd
}

pkg_preinst() {
	if has livecvsportage ${FEATURES} && [ "${ROOT}" = "/" ]; then
		rm -rf ${IMAGE}/usr/lib/portage/pym/*
		mv ${IMAGE}/usr/lib/portage/bin/tbz2tool ${T}
		rm -rf ${IMAGE}/usr/lib/portage/bin/*
		mv ${T}/tbz2tool ${IMAGE}/usr/lib/portage/bin/
	else
		for mydir in pym pym/cache pym/elog_modules; do
			rm /usr/lib/portage/${mydir}/*.pyc >& /dev/null
			rm /usr/lib/portage/${mydir}/*.pyo >& /dev/null
		done
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

	ewarn "This series contains a completely rewritten caching framework."
	ewarn "If you are using any cache modules (such as the CDB cache"
	ewarn "module) portage will not work until they have been disabled."
	echo
	einfo "The default cache format has changed between 2.0.x and 2.1"
	einfo "versions. If you have upgraded from 2.0.x, before using"
	einfo "emerge, run \`emerge --metadata\` to restore portage's local"
	einfo "cache."
	echo
	einfo "Flag ordering has changed for \`emerge --pretend --verbose\`."
	einfo "Add EMERGE_DEFAULT_OPTS=\"--alphabetical\" to /etc/make.conf"
	einfo "to restore the previous ordering."
	echo
	einfo "See NEWS and RELEASE-NOTES for further changes."

	portage_docs
}
