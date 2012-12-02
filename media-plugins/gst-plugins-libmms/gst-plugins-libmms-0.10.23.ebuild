# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-0.10.23.ebuild,v 1.1 2012/12/02 17:57:53 eva Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-libs/libmms-0.4"
DEPEND="${RDEPEND}"
