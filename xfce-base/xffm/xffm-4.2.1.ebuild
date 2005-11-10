# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xffm/xffm-4.2.1.ebuild,v 1.4 2005/11/10 05:59:50 vapier Exp $

inherit xfce4 eutils

DESCRIPTION="Xfce 4 file manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="samba"

RDEPEND="~xfce-base/xfce-mcs-manager-${PV}
	samba? ( net-fs/samba )"
XFCE_CONFIG="--enable-all"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc4.patch
}
