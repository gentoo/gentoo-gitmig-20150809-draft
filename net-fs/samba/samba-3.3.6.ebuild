# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-3.3.6.ebuild,v 1.1 2009/06/26 20:25:35 patrick Exp $

EAPI="2"

DESCRIPTION="Meta package for samba-{libs,client,server}"
HOMEPAGE="http://www.samba.org/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+client +server"

DEPEND=""
RDEPEND="~net-fs/samba-libs-${PV}
	client? ( ~net-fs/samba-client-${PV} )
	server? ( ~net-fs/samba-server-${PV} )"
