# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/evfs/evfs-9999.ebuild,v 1.2 2005/10/12 00:30:46 vapier Exp $

ECVS_MODULE="e17/apps/evfs"
inherit enlightenment

DESCRIPTION="Enlightenment File Daemon"

IUSE="fam samba threads"

DEPEND="x11-libs/ecore
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
