# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/xtables-addons/xtables-addons-1.30.ebuild,v 1.2 2010/10/25 08:18:36 swegener Exp $

EAPI="3"

inherit eutils linux-mod multilib

DESCRIPTION="extensions not yet accepted in the main kernel/iptables (patch-o-matic(-ng) successor)"
HOMEPAGE="http://xtables-addons.sourceforge.net/"
SRC_URI="mirror://sourceforge/xtables-addons/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="modules"

MODULES="quota2 psd pknock lscan length2 ipv4options ipset ipp2p iface geoip fuzzy condition tee tarpit sysrq steal rawnat logmark ipmark echo dhcpmac delude checksum chaos account"

for mod in ${MODULES}; do
	IUSE="${IUSE} xtables_addons_${mod}"
done

DEPEND="virtual/modutils
	>=net-firewall/iptables-1.4.3"

RDEPEND="${DEPEND}
	xtables_addons_ipset? ( !net-firewall/ipset )
	xtables_addons_geoip? ( virtual/perl-Getopt-Long
		dev-perl/Text-CSV_XS )"

DEPEND="${DEPEND}
	>virtual/linux-sources-2.6.22"

pkg_setup()	{
	if use modules; then
		get_version
		check_modules_supported
		# CONFIG_IP_NF_CONNTRACK{,_MARK} doesn't exist in >virtual/linux-sources-2.6.22
		CONFIG_CHECK="NF_CONNTRACK NF_CONNTRACK_MARK"
		linux-mod_pkg_setup

		if ! linux_chkconfig_present IPV6; then
			SKIP_IPV6_MODULES="ip6table_rawpost"
		fi
	fi
}

# Helper for maintainer: cheks if all possible MODULES are listed.
XA_qa_check() {
	local all_modules
	all_modules=$(sed -n '/^build_/{s/build_\(.*\)=.*/\L\1/;G;s/\n/ /;s/ $//;h}; ${x;p}' "${S}/mconfig")
	if [[ ${all_modules} != ${MODULES} ]]; then
		ewarn "QA: Modules in mconfig differ from \$MODULES in ebuild."
		ewarn "Please, update MODULES in ebuild."
		ewarn "'${all_modules}'"
	fi
}

# Is there any use flag set?
XA_has_something_to_build() {
	local mod
	for mod in ${MODULES}; do
		use xtables_addons_${mod} && return
	done

	eerror "All modules are disabled. What do you want me to build?"
	eerror "Please, set XTABLES_ADDONS to any combination of"
	eerror "${MODULES}"
	die "All modules are disabled."
}

# Parse Kbuid files and generates list of sources
XA_get_module_name() {
	[[ $# != 1 ]] && die "XA_get_sources_for_mod: needs exactly one argument."
	local mod objdir build_mod sources_list
	mod=${1}
	objdir=${S}/extensions
	build_mod=$(sed -n "s/\(build_${mod}\)=.*/\1/Ip" "${S}/mconfig")
	sources_list=$(sed -n "/^obj-[$][{]${build_mod}[}]/\
		{s:obj-[^+]\+ [+]=[[:space:]]*::;s:[.]o::g;p}" \
				"${objdir}/Kbuild")

	if [[ -d ${S}/extensions/${sources_list} ]]; then
		objdir=${S}/extensions/${sources_list}
		sources_list=$(sed -n "/^obj-m/\
			{s:obj-[^+]\+ [+]=[[:space:]]*::;s:[.]o::g;p}" \
				"${objdir}/Kbuild")
	fi
	for mod_src in ${sources_list}; do
		has ${mod_src} ${SKIP_IPV6_MODULES} || \
			echo " ${mod_src}(xtables_addons:${S}/extensions:${objdir})"
	done
}

src_prepare() {
	XA_qa_check
	XA_has_something_to_build

	local mod module_name
	if use modules; then
		MODULE_NAMES="compat_xtables(xtables_addons:${S}/extensions:)"
	fi
	for mod in ${MODULES}; do
		if use xtables_addons_${mod}; then
			sed "s/\(build_${mod}=\).*/\1m/I" -i mconfig || die
			if use modules; then
				for module_name in $(XA_get_module_name ${mod}); do
					MODULE_NAMES+=" ${module_name}"
				done
			fi
		else
			sed "s/\(build_${mod}=\).*/\1n/I" -i mconfig || die
		fi
	done

	sed -e 's/depmod -a/true/' -i Makefile.in || die
	sed -e '/^all-local:/{s: modules::}' \
		-e '/^install-exec-local:/{s: modules_install::}' \
			-i extensions/Makefile.in || die

	use xtables_addons_geoip || sed  -e '/^SUBDIRS/{s/geoip//}' -i Makefile.in
}

src_configure() {
	unset ARCH # .. or it'll look for /arch/amd64/Makefile in linux sources
	export KBUILD_EXTMOD=${S} # Avoid build in /usr/src/linux #250407
	econf --prefix="${EPREFIX}/" \
		--libexecdir="${EPREFIX}/$(get_libdir)/" \
		--with-kbuild="${KV_DIR}"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" V=1 || die
	use modules && BUILD_TARGETS="modules" linux-mod_src_compile
}

src_install() {
	emake DESTDIR="${D}" install || die
	use modules && linux-mod_src_install
	dodoc README doc/* || die
	find "${ED}" -type f -name '*.la' -exec rm -rf '{}' '+'
}
