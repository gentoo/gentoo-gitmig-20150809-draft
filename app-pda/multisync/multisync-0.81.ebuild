# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/multisync/multisync-0.81.ebuild,v 1.1 2004/01/10 12:24:05 tad Exp $

DESCRIPTION="Client to sync apps with WinCE or mobile devices"

HOMEPAGE="http://multisync.sourceforge.net/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
MY_P="${PF/r1/1}"
SRC_URI="mirror://sourceforge/multisync/${MY_P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="x86"

# evo   - evolution plugin
# irmc  - bluetooth/irmc/irda plugin ( local )
# opie  - opie plugin                ( local )
# ldap  - ldap plugin - experimental

IUSE="evo irmc opie ldap"

DEPEND="virtual/glibc
		>=gnome-base/libbonobo-2.2
		>=gnome-base/libgnome-2.2
		>=gnome-base/ORBit-0.5.17
		>=dev-libs/openssl-0.9.6j
		evo?  ( gtk2? ( =net-mail/evolution-1.4*
				=x11-libs/gtk+-2* ) :
			      ( =net-mail/evolution-1.2*
				=x11-libs/gtk+-1* )
		)
		irmc? ( >=sys-apps/irda-utils-0.9.15
		         >=net-wireless/bluez-utils-2.3
		         >=dev-libs/openobex-1.0.0 )
		opie? ( >=net-ftp/curl-7.10.5 )
		ldap? ( >=net-nds/openldap-2.0.27
				>=dev-libs/cyrus-sasl-2.1.4 )"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:

S=${WORKDIR}/${PF/-r1/}

PLUGINS="backup_plugin syncml_plugin"

if [ `use irmc` ] ; then
	PLUGINS="${PLUGINS} irmc_sync"
fi
if [ `use evo` ] ; then
	PLUGINS="${PLUGINS} evolution_sync"
fi

if [ `use opie` ] ; then
	PLUGINS="${PLUGINS} opie_sync"
fi

if [ `use ldap` ] ; then
	PLUGINS="${PLUGINS} ldap_plugin"
fi

src_unpack() {
	unpack ${A}

	# Fix the opie Makefile
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.patch
}

src_compile() {
	einfo "Building Multisync with these plugins:"
	for plugin_dir in ${PLUGINS}
	do
		einfo "      ${plugin_dir}"
	done

	cd ${S}
	econf || die
	make || die "Multisync make failed"

	cd ${S}/plugins
	for plugin_dir in ${PLUGINS}
	do
		cd ${S}/plugins/${plugin_dir}
		econf || die "${plugin_dir} config failed!"
		make || die "${plugin_dir} make failed!"
	done
}

src_install() {
	cd ${S}
	einstall || die "Multisync install failed!"
	for plugin_dir in ${PLUGINS}
	do
		cd ${S}/plugins/${plugin_dir}
		einstall || die "${plugin_dir} make failed!"
	done
}
