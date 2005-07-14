# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosip/libosip-2.2.1.ebuild,v 1.1 2005/07/14 18:49:32 johnm Exp $

IUSE="debug threads"

MY_MPV=${PV//.*}

DESCRIPTION="GNU oSIP (Open SIP) library version 2"
HOMEPAGE="http://www.gnu.org/software/osip/"
SRC_URI="mirror://gnu/osip/libosip2-${PV}.tar.gz"
S="${WORKDIR}/${PN}${MY_MPV}-${PV}"

SLOT="${MY_MPV}"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="LGPL-2"

DEPEND="virtual/libc"
#		dev-util/gperf"

src_compile() {
	local myconf
#	myconf="--enable-gperf \
	myconf="--enable-md5 \
			`use_enable threads mt` \
			`use_enable debug`"

	econf ${myconf} || die "Failed to econf"
	emake || die "Failed to emake"
}

src_install() {
	einstall || die "Failed to einstall"
	dodoc AUTHORS BUGS ChangeLog COPYING FEATURES HISTORY INSTALL NEWS README
	TODO
}
