# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/erss/erss-0.0.2.20040207.ebuild,v 1.1 2004/02/08 00:51:24 vapier Exp $

inherit enlightenment

DESCRIPTION="simple tool for watching RSS v1 (RDF) and v2 (XML) feeds"
HOMEPAGE="http://enlightenment.org/pages/erss.html"

DEPEND=">=media-libs/edje-0.0.1.20040110
	>=x11-libs/esmart-0.0.2.20031225
	>=dev-libs/ewd-0.0.1.20031122
	>=x11-libs/ecore-1.0.0.20040201_pre4"

EDOCS="data/erssrc"

src_unpack() {
	enlightenment_src_unpack
	sed -i 's:/local/:/:g' ${S}/data/erssrc
}
