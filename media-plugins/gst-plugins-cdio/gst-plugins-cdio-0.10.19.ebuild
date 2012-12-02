# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdio/gst-plugins-cdio-0.10.19.ebuild,v 1.1 2012/12/02 17:54:23 eva Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/libcdio-0.80"
DEPEND="${RDEPEND}"
