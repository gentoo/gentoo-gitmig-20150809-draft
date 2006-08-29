# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-1.0_pre5.ebuild,v 1.3 2006/08/29 10:20:52 jer Exp $

inherit versionator eutils multilib

MY_PF=$(replace_version_separator '_' '-' ${PF})
S="${WORKDIR}/${MY_PF}"

DESCRIPTION="A library for applications dealing with netlink sockets"
HOMEPAGE="http://people.suug.ch/~tgr/libnl/"
SRC_URI="http://people.suug.ch/~tgr/libnl/files/${MY_PF}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~hppa ~ppc ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install || die \
	"emake install failed"
	dodoc ChangeLog
}
