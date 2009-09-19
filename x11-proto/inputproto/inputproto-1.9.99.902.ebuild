# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/inputproto/inputproto-1.9.99.902.ebuild,v 1.1 2009/09/19 08:47:14 remi Exp $

EAPI="2"

inherit x-modular

DESCRIPTION="X.Org Input protocol headers"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
!<x11-libs/libXi-1.2.99
>=x11-misc/util-macros-1.2"
