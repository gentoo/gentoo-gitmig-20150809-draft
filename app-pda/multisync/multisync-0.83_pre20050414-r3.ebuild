# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/multisync/multisync-0.83_pre20050414-r3.ebuild,v 1.3 2006/03/16 17:40:27 sekretarz Exp $

inherit versionator kde-functions eutils

CVS_VERSION="${PV/*_pre/}"
S=${WORKDIR}/${PN}
export WANT_AUTOMAKE=1.7

DESCRIPTION="Modular sync client which supports an array of plugins."
HOMEPAGE="http://multisync.sourceforge.net/"
SRC_URI="mirror://gentoo/${PN}-${CVS_VERSION}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="evo irmc nokia6600 ldap bluetooth pda kdepim arts kdeenablefinal"
# evo       - evolution plugin
# irmc      - bluetooth/irmc/irda plugin ( local )
# pda       - opie plugin                ( local )
# nokia6600 - support for Nokia 6600     ( local )
# ldap      - ldap plugin - experimental
# kdepim    - sync with the kdepim app
# arts      - potentially required for kdepim.

DEPEND=">=gnome-base/libbonobo-2.2
		>=gnome-base/libgnomeui-2.2
		>=gnome-base/libgnome-2.2
		>=dev-libs/glib-2
		>=gnome-base/gconf-2
		>=gnome-base/gnome-vfs-2.2
		>=gnome-base/orbit-2.8.2
		>=dev-libs/openssl-0.9.6j
		evo?  ( mail-client/evolution )
		irmc? ( >=net-wireless/irda-utils-0.9.15
				=dev-libs/openobex-1.0*
				bluetooth? ( 	>=net-wireless/bluez-libs-2.7
				         		>=net-wireless/bluez-utils-2.7 ) )
		pda? ( >=net-misc/curl-7.10.5
				app-pda/pilot-link )
		kdepim? ( || ( kde-base/kdepim-meta kde-base/kdepim )
				  arts? ( kde-base/arts ) )
		ldap? ( >=net-nds/openldap-2.0.27
				>=dev-libs/cyrus-sasl-2.1.4 )
		nokia6600? ( >=dev-libs/libwbxml-0.9.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-gcc4.patch
}

make_plugin_list() {
	local evoversion

	PLUGINS="backup_plugin syncml_plugin"
	if use evo
	then
		evoversion="$(best_version mail-client/evolution)"
		# remove prefix
		evoversion=${evoversion//*evolution-}
		# remove revisions
		evoversion=${evoversion//-*}
		# find major
		evoversion=$(get_major_version ${evoversion})

		[[ ${evoversion} -eq 2 ]] 	&& PLUGINS="${PLUGINS} evolution2_sync"
		[[ ${evoversion} -eq 1 ]] 	&& PLUGINS="${PLUGINS} evolution_sync"
	fi
	use irmc 	&& PLUGINS="${PLUGINS} irmc_sync"
	use pda 	&& PLUGINS="${PLUGINS} opie_sync palm_sync"
	use ldap 	&& PLUGINS="${PLUGINS} ldap_plugin"
	use kdepim	&& PLUGINS="${PLUGINS} kdepim_plugin"
}

run_compile() {
	aclocal || die "failed aclocal"
	libtoolize --copy --force || die "libtoolize failed!"
	autoheader || die "Failed during autoheader!"
	automake --add-missing --gnu || die "Failed during automake!"
	autoconf || die "Failed during autoconf!"
	econf CPPFLAGS="${myInc} ${CPPFLAGS}" ${myConf} || die "Failed during econf!"
	make || die "Failed during make!"
}

src_compile() {
	[[ -z ${PLUGINS} ]] && make_plugin_list

	einfo "Building Multisync with these plugins:"
	for plugin_dir in ${PLUGINS}; do
		einfo "      ${plugin_dir}"
	done

	cd ${S}
	if use kdepim; then
		set-qtdir 3
		set-kdedir 3
		myInc="-I${KDEDIR}/include ${myInc}"
		myConf="$(use_with arts)
				$(use_enable kdeenablefinal final)"
	fi

	use pda && myInc="-I/usr/include/libpisock ${myInc}"
	run_compile;
	for plugin_dir in ${PLUGINS}; do
		einfo "Building ${plugin_dir}"
		cd ${S}/plugins/${plugin_dir}
		run_compile;
	done
}

src_install() {
	[[ -z ${PLUGINS} ]] && make_plugin_list

	einstall || die "Multisync install failed!"
	for plugin_dir in ${PLUGINS}; do
		cd ${S}/plugins/${plugin_dir}
		make install DESTDIR=${D} || die "${plugin_dir} make install failed!"
	done
}
