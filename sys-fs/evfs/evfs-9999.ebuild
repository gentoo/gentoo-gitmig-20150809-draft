# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/evfs/evfs-9999.ebuild,v 1.3 2006/08/06 15:50:23 vapier Exp $

ECVS_MODULE="e17/apps/evfs"
inherit enlightenment

DESCRIPTION="Enlightenment File Daemon"

IUSE="fam samba threads"

DEPEND="x11-libs/ecore
	dev-db/sqlite
	fam? ( virtual/fam )
	samba? ( net-fs/samba )
	dev-libs/libxml2"

src_compile() {
	export MY_ECONF="
		$(use_with fam)
		$(use_enable samba)
		$(use_enable threads)
	"
	enlightenment_src_compile
}
