# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/erss/erss-0.0.2.20040124.ebuild,v 1.3 2004/01/25 21:50:08 vapier Exp $

inherit enlightenment

DESCRIPTION="RSS feed reader using EFL libs"

DEPEND=">=media-libs/edje-0.0.1.20040110
	>=x11-libs/esmart-0.0.2.20031225
	>=dev-libs/ewd-0.0.1.20031122"

EDOCS="data/erssrc"

src_unpack() {
	enlightenment_src_unpack
	sed -i 's:/local/:/:g' ${S}/data/erssrc
}
