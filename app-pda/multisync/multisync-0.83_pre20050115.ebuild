# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/multisync/multisync-0.83_pre20050115.ebuild,v 1.1 2005/01/20 19:15:05 johnm Exp $

inherit eutils versionator

CVS_VERSION="20050115"
MY_PV="0.82"
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="Modular sync client which supports an array of plugins."
HOMEPAGE="http://multisync.sourceforge.net/"
SRC_URI="mirror://sourceforge/multisync/${PN}-${MY_PV}.tar.bz2 \
		mirror://gentoo/${PN}-${CVS_VERSION}-snapshot.tar.gz"

RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"
IUSE="evo irmc opie ldap bluetooth kdepim"
# evo    - evolution plugin
# irmc   - bluetooth/irmc/irda plugin ( local )
# opie   - opie plugin                ( local )
# ldap   - ldap plugin - experimental
# gnokii - Sync mobile phonebook via gnokii - currently boken (missing vfolder)
# csa    - sync with solaris calendar server - currently broken
# kdepim - sync with the kde3 address book.

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
			>=dev-libs/openobex-1
			bluetooth? ( 	>=net-wireless/bluez-libs-2.7
			         		>=net-wireless/bluez-utils-2.7 ) )
	opie? ( >=net-misc/curl-7.10.5 )
	ldap? ( >=net-nds/openldap-2.0.27
		>=dev-libs/cyrus-sasl-2.1.4 )
	kdepim? ( >=kde-base/kdepim-3 )"

src_unpack() {
	unpack ${PN}-${MY_PV}.tar.bz2

	cd ${S}
	# Unpack stuff we want from the cvs build
	tar -xzpf ${DISTDIR}/${PN}-${CVS_VERSION}-snapshot.tar.gz \
		multisync/specs/multisync-evolution2.spec.in \
		multisync/specs/multisync-irmc-bluetooth.spec.in \
		multisync/specs/multisync-irmc.spec.in \
		multisync/specs/multisync-opie.spec.in \
		multisync/specs/multisync-kdepim.spec.in \
		multisync/plugins/evolution2_sync \
		multisync/plugins/irmc_sync \
		multisync/plugins/opie_sync \
		multisync/plugins/kdepim_plugin

	# copy additional plugins over
	mv multisync/plugins/evolution2_sync ${S}/plugins/
	mv multisync/plugins/kdepim_plugin ${S}/plugins/
	mv multisync/specs/multisync-evolution2.spec.in ${S}/specs
	mv multisync/specs/multisync-kdepim.spec.in ${S}/specs

	# fix up irmc_sync issues with bluez-sdp deprecation by using irmc_plugin
	# from cvs
	rm -Rf ${S}/plugins/irmc_sync
	rm -Rf ${S}/specs/multisync-irmc*
	mv multisync/plugins/irmc_sync ${S}/plugins/
	mv multisync/specs/multisync-irmc.spec.in ${S}/specs
	mv multisync/specs/multisync-irmc-bluetooth.spec.in ${S}/specs

	# Update opie_sync to cvs version
	rm -Rf ${S}/plugins/opie_sync
	rm -Rf ${S}/specs/multisync-opie*
	mv multisync/specs/multisync-opie.spec.in ${S}/specs
	mv multisync/plugins/opie_sync ${S}/plugins/

	# remove cvs tarball
	rm -Rf multisync/
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
	use opie 	&& PLUGINS="${PLUGINS} opie_sync"
	use ldap 	&& PLUGINS="${PLUGINS} ldap_plugin"
	use kdepim 	&& PLUGINS="${PLUGINS} kdepim_plugin"
}

src_compile() {
	make_plugin_list

	einfo "Building Multisync with these plugins:"
	for plugin_dir in ${PLUGINS}
	do
		einfo "      ${plugin_dir}"
	done

	cd ${S}
	libtoolize --copy --force || die
	econf || die
	make || die "Multisync make failed"

	for plugin_dir in ${PLUGINS}
	do
		einfo "Building ${plugin_dir}"
		cd ${S}/plugins/${plugin_dir}
		econf || die "${plugin_dir} config failed!"
		emake || die "${plugin_dir} make failed!"
	done
}

src_install() {
	make_plugin_list
	einstall || die "Multisync install failed!"
	for plugin_dir in ${PLUGINS}
	do
		cd ${S}/plugins/${plugin_dir}
		einstall || die "${plugin_dir} make failed!"
	done
}
