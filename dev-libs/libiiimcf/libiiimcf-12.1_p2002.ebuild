# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiiimcf/libiiimcf-12.1_p2002.ebuild,v 1.1 2005/03/30 17:07:52 usata Exp $

inherit iiimf eutils

DESCRIPTION="A library to implement generic C interface for IIIM Client"
SRC_URI="http://www.openi18n.org/download/im-sdk/src/${IMSDK_P}.tar.bz2"

KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/eimil-${PV}
	>=dev-libs/libiiimp-${PV}"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	>=sys-apps/sed-4"

S="${WORKDIR}/${IMSDK}/lib/iiimcf"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:../EIMIL:/usr/lib:g" \
		-e "s:../iiimp:/usr/lib:g" Makefile* || die "sed failed"
	autoconf
}
